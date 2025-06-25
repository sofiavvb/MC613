module uart (
	 // === Clock e Rest ===
    input  wire        clk,
    input  wire        reset,

    // === UART Leitura ===
    output reg  [7:0]  rx_data,
    output reg         rx_valid,
	 
	 // === UART Escrita ===
    input  wire [7:0]  tx_data,
    input  wire        tx_valid,
    output wire        tx_ready,

    // === Sinais Avalon-MM para a JTAG UART ===
    output wire        av_chipselect,
    output wire        av_address,
    output wire        av_read_n,
    input  wire [31:0] av_readdata,
    output wire        av_write_n,
    output wire [31:0] av_writedata,
    input  wire        av_waitrequest
);

    assign av_chipselect = 1'b1;
    assign av_address = 1'b0;

    // leitura
    reg reading = 0;
    assign av_read_n = ~reading;

    // escrita
    reg writing = 0;
    assign av_write_n = ~writing;
    assign av_writedata = {24'd0, tx_data};
    assign tx_ready = !writing && !av_waitrequest;

    // === RX FSM ===
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rx_valid <= 0;
            reading <= 0;
        end else begin
            if (!reading) begin
                reading <= 1;
            end else if (!av_waitrequest) begin
                reading <= 0;
                rx_data <= av_readdata[7:0];
                rx_valid <= av_readdata[15]; // Bit de validade
            end else begin
                rx_valid <= 0;
            end
        end
    end

    // === TX FSM ===
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            writing <= 0;
        end else begin
            if (tx_valid && !writing && !av_waitrequest) begin
                writing <= 1;
            end else if (writing && !av_waitrequest) begin
                writing <= 0;
            end
        end
    end

endmodule
