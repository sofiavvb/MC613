module tb_timer;
    reg clk = 0;
    reg reset;
    wire [5:0] min;
    wire [5:0] seg;
    wire [6:0] cent;

    // Clock de 10 unidades de tempo
    always #5 clk = ~clk;

    timer uut (
        .clk(clk),
        .reset(reset),
        .min(min),
        .seg(seg),
        .cent(cent)
    );

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_timer);
        $monitor("Tempo: %0d min : %0d seg : %0d cent", min, seg, cent);

        reset = 1;
        #20;
        reset = 0;

        #1000;  // simula tempo suficiente para contar
        $finish;
    end
endmodule
