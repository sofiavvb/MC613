module alu_tb;
    logic [31:0] A, B;
    logic [1:0] ALUCtl;
    logic [31:0] R; //saida resultado
    logic Zero, Overflow, Cout; //flags

    // Instância da ALU
    alu alu_inst ( //conecta os sinais da ALU
        .A(A),
        .B(B),
        .ALUCtl(ALUCtl),
        .R(R),
        .Zero(Zero),
        .Overflow(Overflow),
        .Cout(Cout)
    );
    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        //AND
        A = 32'hF0F0F0F0;// 11110000 11110000 11110000 11110000
        B = 32'h0F0F0F0F;// 00001111 00001111 00001111 00001111
        ALUCtl = 2'b00;
        #10; //vai dar zero
        $display("AND Test: A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);

        //OR
        A = 32'hF0F0F0F0;
        B = 32'h0F0F0F0F;
        ALUCtl = 2'b10;
        #10; //vai dar 1
        $display("OR Test: A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);

        //soma sem overflow
        A = 32'h00000001;
        B = 32'h00000001;
        ALUCtl = 2'b01;
        #10;
        $display("Soma Test (sem overflow): A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);

        //soma com overflow
        A = 32'h7FFFFFFF; //01111111 11111111 11111111 11111111 (máximo valor positivo)
        B = 32'h00000001; //00000000 00000000 00000000 00000001
        ALUCtl = 2'b01;
        #10;
        $display("Soma Test (com overflow): A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);


        //soma com cout
        A = 32'hFFFFFFFF; 
        B = 32'h00000001; 
        ALUCtl = 2'b01;
        #10;
        $display("Soma Test (com overflow): A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);


        //subtração sem overflow
        A = 32'h00000005;
        B = 32'h00000003;
        ALUCtl = 2'b11;
        #10;
        $display("Subtração Test (sem overflow): A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);

        //subtração com overflow
        A = 32'h80000000;//10000000 00000000 00000000 00000000 (valor negativo máximo)
        B = 32'h00000001;//00000000 00000000 00000000 00000001
        ALUCtl = 2'b11;
        #10;
        $display("Subtração Test (com overflow): A = %h, B = %h, R = %h, Zero = %b, Overflow = %b, Cout = %b", A, B, R, Zero, Overflow, Cout);
        
        $finish;
    end

endmodule
