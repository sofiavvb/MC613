// clock para board -> unit watch e stopwatch

module clock (
    input logic CLOCK_50,
    input logic[3:0] KEY,
    input logic [9:0] SW,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

    logic rst, start_stop_btn;

    // Instanciação do cronômetro
    stopwatch stopwatch_inst (
        .clk(CLOCK_50),
        .rst(rst),
        .start_stop_btn(start_stop_btn),
        // outros sinais de exibição ainda serão conectados
    );

endmodule
