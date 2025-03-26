module alu (
    input logic [31:0] A,
    input logic [31:0] B,
    input logic [1:0] ALUCtl, 
    output logic [31:0] R,
    output logic Zero,
    output logic Overflow,
    output logic Cout
);

    logic[31:0] sinalb;


    always_comb begin

        //default para as operacoes logicas
        Cout = 1'b0;
        
        if (ALUCtl == 2'b00) begin
            R = A & B; // and
        end else if (ALUCtl == 2'b10) begin
            R = A | B; // or
        end else if (ALUCtl == 2'b01) begin
            //extendemos o registrador e pegamos o 33 bit pro carry 
            {Cout, R} = A + B; 
            //se os dois numeros forem positivos e o resultado negativo OU se os dois numeros forem negativos e o resultado positivo
        end else if (ALUCtl == 2'b11) begin
            {Cout, R} = A - B; // subtração com Cout
        end    
    end
    assign Zero = (R == 32'b0);
    assign Overflow = (~A[31] & ~B[31] & R[31]) | (A[31] & sinalb[31] & ~R[31]);
    assign sinalb = (ALUCtl[1]) ? ~B : B;
    
endmodule
