`timescale 1ns / 1ps

module tb_stopwatch;
    logic clk;
    logic rst;
    logic start_stop_btn;
    logic [6:0] centesimos;
    logic [5:0] segundos;
    logic [6:0] minutos;

    stopwatch uut (
        .clk(clk),
        .rst(rst),
        .start_stop_btn(start_stop_btn),
        .centesimos(centesimos),
        .segundos(segundos),
        .minutos(minutos)
    );

    //clock: período de 20ns (50MHz)
    always #10 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start_stop_btn = 0;

        // aplica reset por 50ns
        #50;
        rst = 0;

        #100;
        start_stop_btn = 1;
        #20;
        start_stop_btn = 0;

        //roda por um tempo simulado
        #10_000_000; // ~10ms de simulação 

        //pausa
        start_stop_btn = 1;
        #20;
        start_stop_btn = 0;

        //cronômetro parado
        #100_000;

        $stop;
    end

    always_ff @(posedge clk) begin
        $display("Tempo: %0d min : %0d seg : %0d cent", minutos, segundos, centesimos);
    end

endmodule
