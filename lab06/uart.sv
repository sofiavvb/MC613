// uart com receptor, transmissor e divisor de clock instanciados

module uart(
    input logic clk,
    input logic rst,
    input logic send,
    input logic [7:0] tx_data,
    input logic rx,
    output logic tx,
    output logic [7:0] rx_data,
    output logic tx_busy,
    output logic rx_done
);

    logic tick;

    // Divisor de Clock
    div_clock #(.DIV(5208)) clock_inst (
        .clk(clk),
        .rst(rst),
        .pulse(tick)
    );

    // Transmissor UART
    tx tx_inst (
        .clk(clk),
        .tick(tick),
        .send(send),
        .data_in(tx_data),
        .tx(tx),
        .busy(tx_busy)
    );

    // Receptor UART
    rx rx_inst (
        .clk(clk),
        .tick(tick),
        .rx(rx),
        .data_out(rx_data),
        .done(rx_done)
    );

endmodule