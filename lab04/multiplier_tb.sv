`timescale 1ns/1ps

module multiplier_tb;
    parameter int N = 4;

    logic clk;
    logic set;
    logic [N-1:0] a, b;
    logic [2*N-1:0] r;


    multiplier #(.N(N)) dut (
        .clk(clk),
        .set(set),
        .a(a),
        .b(b),
        .r(r)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("multiplier_tb.vcd");
        $dumpvars(0, multiplier_tb);
        // Inicialização
        set = 0;
        a = 0;
        b = 0;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);

        
        // Teste 1: 3 * 5 = 15
        a = 4'd3;
        b = 4'd5;
        set = 1;
        #10;
        set = 0;

        #120;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);

        // Teste 2: 7 * 2 = 14
        a = 4'd7;
        b = 4'd2;
        set = 1;
        #10;
        set = 0;
        #120;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);

        // Teste 3: 0 * 9 = 0
        a = 4'd0;
        b = 4'd9;
        set = 1;
        #10;
        set = 0;
        #120;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);   

        // Teste 4: 15 * 15 = 225
        a = 4'd15;
        b = 4'd15;
        set = 1;
        #10;
        set = 0;
        #120;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);   

        // Teste 5: 1 * 12 = 12
        a = 4'd1;
        b = 4'd12;
        set = 1;
        #10;
        set = 0;
        #120;
        $display("Tempo: %0t | A: %0d | B: %0d | Set: %b | R: %0d", 
                  $time, a, b, set, r);   

        $finish;
    end

endmodule
