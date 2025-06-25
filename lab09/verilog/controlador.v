module controlador (
    input wire CLOCK_50,
    output wire [7:0] LEDR 
);
 
    wire clk = CLOCK_50;
    wire reset = 1'b0; // reset = 0 COLOCAR BOTAO RESET DEPOIS

	 // sinais uart
    wire [7:0] rx_data;
    wire rx_valid;
    reg [7:0] tx_data;
    reg tx_valid;
    wire tx_ready;

    // sinais uart virtual
    wire jtag_uart_cs;
    wire jtag_uart_addr;
    wire jtag_uart_read;
    wire [31:0] jtag_uart_readdata;
    wire jtag_uart_write;
    wire [31:0] jtag_uart_writedata;
    wire jtag_uart_waitrequest;

    // sinais controle e acelerador
    reg acelerador_start;
    wire acelerador_done;
    wire [15:0] acelerador_read_addr;
    wire acelerador_read_en;
    wire [7:0] acelerador_pixel_in;
    wire [15:0] acelerador_write_addr;
    wire acelerador_write_en;
    wire [7:0] acelerador_pixel_out;	 
	 
	 // buffers 
    reg [7:0] imagem_in [0:65535];
    reg [7:0] imagem_out [0:65535];
	 
	 
    uart_interface uart_inst (
        .clk (clk),
        .reset (reset),
        .rx_data (rx_data),
        .rx_valid (rx_valid),
        .tx_data (tx_data),
        .tx_valid (tx_valid),
        .tx_ready (tx_ready),
        .jtag_uart_cs (jtag_uart_cs),
        .jtag_uart_addr (jtag_uart_addr),
        .jtag_uart_read (jtag_uart_read),
        .jtag_uart_readdata (jtag_uart_readdata),
        .jtag_uart_write (jtag_uart_write),
        .jtag_uart_writedata (jtag_uart_writedata),
        .jtag_uart_waitrequest (jtag_uart_waitrequest)
    );

    acelerador acelerador_inst (
        .clk (clk),
        .reset (reset),
        .start (acelerador_start),
        .done (acelerador_done),
        .altura (altura),
        .largura (largura),
        .pixel_in (acelerador_pixel_in),
        .read_addr (acelerador_read_addr),
        .read_en (acelerador_read_en),
        .pixel_out (acelerador_pixel_out),
        .write_addr (acelerador_write_addr),
        .write_en (acelerador_write_en)
    );
	 
	     jtag_uart jtag_uart_inst (
        .clk_clk (clk),
        .reset_reset_n (~reset),
        .av_chipselect (jtag_uart_cs),
        .av_address (jtag_uart_addr),
        .av_read_n (~jtag_uart_read),
        .av_readdata (jtag_uart_readdata),
        .av_write_n (~jtag_uart_write),
        .av_writedata (jtag_uart_writedata),
        .av_waitrequest (jtag_uart_waitrequest),
        .irq_irq () // nao usa
    );


	 // leitura pixel
    assign acelerador_pixel_in = imagem_in[acelerador_read_addr];

    // escrita pixel processado
    always @(posedge clk) begin
        if (acelerador_write_en) begin
            imagem_out[acelerador_write_addr] <= acelerador_pixel_out;
        end
    end

    // FSM
    typedef enum logic [3:0] {
        IDLE, // aguarda inicio byte 0xAA
        RECEBE_ALTURA,  
        RECEBE_LARGURA, 
        RECEBE_PIXELS, // recebe imagem pixel por pixel
        PROCESSA_START, // inicia acelerador
        PROCESSA_WAIT, // espera fim acelerador
        ENVIA_HEADER, // envia byte parada 0x55
        ENVIA_PIXELS // envia imagem processada
    } estado_t;

    estado_t estado = IDLE;

    reg [7:0] altura, largura;
    reg [15:0] byte_count; // contador para recepcao e transmissao

    always @(posedge clk) begin
        tx_valid <= 1'b0;
        acelerador_start <= 1'b0;

        case (estado)
            IDLE: begin
                // aguarda 0xAA
                if (rx_valid && rx_data == 8'hAA) begin
                    estado <= RECEBE_ALTURA;
                end
            end

            RECEBE_ALTURA: begin
                // recebe altura da imagem
                if (rx_valid) begin
                    altura <= rx_data;
                    estado <= RECEBE_LARGURA;
                end
            end

            RECEBE_LARGURA: begin
                // recebe largura 
                if (rx_valid) begin
                    largura <= rx_data;
                    byte_count <= 0;
                    estado <= RECEBE_PIXELS;
                end
            end

            RECEBE_PIXELS: begin
                // armazena os pixels recebidos na memoria
                if (rx_valid) begin
                    imagem_in[byte_count] <= rx_data;
                    byte_count <= byte_count + 1;
                    // se todos os pixels foram recebidos -> inicia o processamento
                    if (byte_count + 1 == altura * largura) begin
                        estado <= PROCESSA_START;
                    end
                end
            end

            PROCESSA_START: begin
                // inicia acelerador
                acelerador_start <= 1'b1;
                estado <= PROCESSA_WAIT;
            end
            
            PROCESSA_WAIT: begin
                // finaliza acelerador
                acelerador_start <= 1'b0;
                if (acelerador_done) begin
                    byte_count <= 0; // Reseta o contador para o envio
                    estado <= ENVIA_HEADER;
                end
            end

            ENVIA_HEADER: begin
                // envia o byte de fim 0x55
                if (tx_ready) begin
                    tx_data <= 8'h55;
                    tx_valid <= 1;
                    estado <= ENVIA_PIXELS;
                end
            end

            ENVIA_PIXELS: begin
                // envia os pixels da memória de saída (imagem processada)
                if (tx_ready) begin
                    tx_data <= imagem_out[byte_count];
                    tx_valid <= 1;
                    byte_count <= byte_count + 1;
                    // se todos os pixels foram enviados -> retorna a IDLE
                    if (byte_count + 1 == altura * largura) begin
                        estado <= IDLE;
                    end
                end
            end
        endcase
    end

    // conecta a saída de dados da uart aos leds
    assign LEDR = tx_data;
 
endmodule