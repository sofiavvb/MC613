// implementacao da uart na board

module uart_board (
    input logic CLOCK_50,
    input logic [7:0] SW,        // Dados a transmitir
    input logic [1:0] KEY,       // KEY[0] = enviar, KEY[1] = limpar
    output logic [7:0] LEDR,     // Dados recebidos
    inout wire [35:0] GPIO_0     // GPIO_0[0] = TX, GPIO_0[1] = RX
);

    logic rst = 0;

    logic pulse;
    logic send, busy;
    logic [7:0] tx_data;
    logic tx;

    logic [7:0] rx_data;
    logic rx_done;
    logic rx_clear;

    assign send = ~KEY[0];     
    assign rx_clear = ~KEY[1]; 

    // UART TX
    uart_tx uart_tx_inst (
        .clk(CLOCK_50),
        .tick(pulse),
        .send(send),
        .data_in(SW),
        .tx(GPIO_0[0]),  // TX para GPIO
        .busy(busy)
    );

    // UART RX
    uart_rx uart_rx_inst (
        .clk(CLOCK_50),
        .tick(pulse),
        .rx(GPIO_0[1]),     // RX da GPIO
        .data_out(rx_data),
        .done(rx_done)
    );

    // Clock para taxa de 9600 bits/s (mudar taxa aqui e no testbench)
    div_clock #(.DIV(5208)) div_clock_inst (
        .clk(CLOCK_50),
        .rst(rst),
        .pulse(pulse)
    );

    // Armazenar valor recebido
    always_ff @(posedge CLOCK_50) begin
        if (rx_done)
            LEDR <= rx_data;
        else if (rx_clear)
            LEDR <= 8'b0;
    end

endmodule
