module controlador (
    input wire CLOCK_50,
    output wire [7:0] LEDR 
);
 
    wire clk = CLOCK_50;
    wire reset = 1'b0; // reset = 0 COLOCAR BOTAO RESET DEPOIS

	 // sinais uart
    wire [7:0] rx_data;
    wire       rx_valid;
    reg  [7:0] tx_data;
    reg        tx_valid;
    wire       tx_ready;

    // --- Sinais de interface com o IP JTAG UART ---
    wire        jtag_uart_cs;
    wire        jtag_uart_addr;
    wire        jtag_uart_read;
    wire [31:0] jtag_uart_readdata;
    wire        jtag_uart_write;
    wire [31:0] jtag_uart_writedata;
    wire        jtag_uart_waitrequest;

    // Instância do JTAG UART 
    uart_interface uart_inst (
        .clk                 (clk),
        .reset               (reset),
        .rx_data             (rx_data),
        .rx_valid            (rx_valid),
        .tx_data             (tx_data),
        .tx_valid            (tx_valid),
        .tx_ready            (tx_ready),
        .jtag_uart_cs        (jtag_uart_cs),
        .jtag_uart_addr      (jtag_uart_addr),
        .jtag_uart_read      (jtag_uart_read),
        .jtag_uart_readdata  (jtag_uart_readdata),
        .jtag_uart_write     (jtag_uart_write),
        .jtag_uart_writedata (jtag_uart_writedata),
        .jtag_uart_waitrequest(jtag_uart_waitrequest)
    );

    // --- Sinais de controle e dados para o Acelerador Sobel ---
    reg         acelerador_start;
    wire        acelerador_done;
    wire [15:0] acelerador_read_addr;
    wire        acelerador_read_en;
    wire [7:0]  acelerador_pixel_in;
    wire [15:0] acelerador_write_addr;
    wire        acelerador_write_en;
    wire [7:0]  acelerador_pixel_out;

    // --- Memórias de Imagem ---
    // Duas memórias são usadas para permitir que o acelerador leia a imagem
    // original enquanto escreve a imagem processada, evitando corrupção de dados.
    // Suporta imagens de até 256x256 pixels.
    reg [7:0] imagem_in [0:65535];
    reg [7:0] imagem_out [0:65535];

    // --- Instância do Acelerador Sobel ---
    acelerador acelerador_inst (
        .clk        (clk),
        .reset      (reset),
        .start      (acelerador_start),
        .done       (acelerador_done),
        .altura     (altura),
        .largura    (largura),
        .pixel_in   (acelerador_pixel_in),
        .read_addr  (acelerador_read_addr),
        .read_en    (acelerador_read_en),
        .pixel_out  (acelerador_pixel_out),
        .write_addr (acelerador_write_addr),
        .write_en   (acelerador_write_en)
    );

    // --- Lógica de Interface com a Memória ---
    // O acelerador solicita a leitura de um pixel da memória de entrada.
    assign acelerador_pixel_in = imagem_in[acelerador_read_addr];

    // O acelerador escreve o pixel processado na memória de saída.
    always @(posedge clk) begin
        if (acelerador_write_en) begin
            imagem_out[acelerador_write_addr] <= acelerador_pixel_out;
        end
    end

    // --- Máquina de Estados Finitos (FSM) do Controlador ---
    typedef enum logic [3:0] {
        IDLE,           // Aguardando início da transmissão (byte 0xAA)
        RECEBE_ALTURA,  // Recebendo o byte da altura da imagem
        RECEBE_LARGURA, // Recebendo o byte da largura da imagem
        RECEBE_PIXELS,  // Recebendo os bytes dos pixels da imagem
        PROCESSA_START, // Inicia o acelerador Sobel
        PROCESSA_WAIT,  // Aguarda o término do processamento
        ENVIA_HEADER,   // Envia um header de resposta (0x55)
        ENVIA_PIXELS    // Envia os pixels da imagem processada
    } estado_t;

    estado_t estado = IDLE;

    reg [7:0] altura, largura;
    reg [15:0] byte_count; // Contador de bytes para recepção e transmissão

    always @(posedge clk) begin
        // Atribuições padrão (são desativadas a menos que um estado as ative)
        tx_valid         <= 1'b0;
        acelerador_start <= 1'b0;

        case (estado)
            IDLE: begin
                // Aguarda o byte de início 0xAA
                if (rx_valid && rx_data == 8'hAA) begin
                    estado <= RECEBE_ALTURA;
                end
            end

            RECEBE_ALTURA: begin
                // Recebe a altura da imagem
                if (rx_valid) begin
                    altura <= rx_data;
                    estado <= RECEBE_LARGURA;
                end
            end

            RECEBE_LARGURA: begin
                // Recebe a largura e prepara para receber os pixels
                if (rx_valid) begin
                    largura <= rx_data;
                    byte_count <= 0;
                    estado <= RECEBE_PIXELS;
                end
            end

            RECEBE_PIXELS: begin
                // Armazena os pixels recebidos na memória de entrada
                if (rx_valid) begin
                    imagem_in[byte_count] <= rx_data;
                    byte_count <= byte_count + 1;
                    // Se todos os pixels foram recebidos, inicia o processamento
                    if (byte_count + 1 == altura * largura) begin
                        estado <= PROCESSA_START;
                    end
                end
            end

            PROCESSA_START: begin
                // Pulsa o sinal 'start' do acelerador por um ciclo
                acelerador_start <= 1'b1;
                estado <= PROCESSA_WAIT;
            end
            
            PROCESSA_WAIT: begin
                // Desativa o sinal 'start' e aguarda o 'done' do acelerador
                acelerador_start <= 1'b0;
                if (acelerador_done) begin
                    byte_count <= 0; // Reseta o contador para o envio
                    estado <= ENVIA_HEADER;
                end
            end

            ENVIA_HEADER: begin
                // Envia o byte de confirmação 0x55
                if (tx_ready) begin
                    tx_data <= 8'h55;
                    tx_valid <= 1;
                    estado <= ENVIA_PIXELS;
                end
            end

            ENVIA_PIXELS: begin
                // Envia os pixels da memória de saída (imagem processada)
                if (tx_ready) begin
                    tx_data <= imagem_out[byte_count];
                    tx_valid <= 1;
                    byte_count <= byte_count + 1;
                    // Se todos os pixels foram enviados, retorna ao estado IDLE
                    if (byte_count + 1 == altura * largura) begin
                        estado <= IDLE;
                    end
                end
            end
        endcase
    end

    // Conecta a saída de dados da UART aos LEDs para debug
    assign LEDR = tx_data;

    // --- Instância do IP JTAG UART (gerado pelo Platform Designer) ---
    jtag_uart jtag_uart_inst (
        .clk_clk          (clk),
        .reset_reset_n    (~reset),
        .av_chipselect    (jtag_uart_cs),
        .av_address       (jtag_uart_addr),
        .av_read_n        (~jtag_uart_read),
        .av_readdata      (jtag_uart_readdata),
        .av_write_n       (~jtag_uart_write),
        .av_writedata     (jtag_uart_writedata),
        .av_waitrequest   (jtag_uart_waitrequest),
        .irq_irq          () // Interrupção não utilizada
    );

endmodule