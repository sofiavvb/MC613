module alu_board (
    input  logic [9:0] SW,      // entrada de switches
    output logic [6:0] HEX5,    // A neg
    output logic [6:0] HEX4,    // A
    output logic [6:0] HEX3,    // B neg
    output logic [6:0] HEX2,    // B
    output logic [6:0] HEX1,    // R neg
    output logic [6:0] HEX0,    // R 
    output logic [9:0] LEDR    // leds
);

    logic [31:0] A, B, R;  // A B e R de 4 bits
    logic [1:0] ALUCtl; // sinal ALUCtl 2 bits
    logic negA, negB, negR; // negativos
    logic Zero, Overflow, Cout; // flags
    logic[31:0] sinalb; // reg extra para resolver overflow
    
    assign ALUCtl = SW[9:8];
    assign A = (SW[7]) ? {28'b1, SW[7:4]} : SW[7:4]; 
    assign B = (SW[3]) ? {28'b1, SW[3:0]} : SW[3:0]; 

    two_comp_to_7seg inst_A (
        .bin(A),
        .segs(HEX4),
        .neg(negA)
    );
    assign HEX5 = {~negA, 6'b111111}; // HEX5[6] é o valor de negA concatenado aos 0

    two_comp_to_7seg inst_B (
        .bin(B),
        .segs(HEX2),
        .neg(negB)
    );
    assign HEX3 = {~negB, 6'b111111}; // HEX3[6] é o valor de negB concatenado aos 0

    two_comp_to_7seg inst_R (
        .bin(R),
        .segs(HEX0),
        .neg(negR)
    );
    assign HEX1 = {~negR, 6'b111111}; /// HEX1[6] é o valor de negR concatenado aos 0

    
    always_comb begin
        Cout = 1'b0; //default para as operacoes logicas
        
        if (ALUCtl == 2'b00) begin
            R = A & B; // and
        end else if (ALUCtl == 2'b10) begin
            R = A | B; // or
        end else if (ALUCtl == 2'b01) begin
            {Cout, R} = A + B; //extendemos o registrador e pegamos o 5 bit pro Cout    
        end else begin //se +A +B = -R OU se -A -B = +R        
            {Cout, R} = A - B; // subtração com Cout
        end    
    end
    assign Zero = (R == 32'b0);
    assign Overflow = (A[31] & B[31] & ~R[31]) | (~A[31] & sinalb[31] & R[31]);
    assign sinalb = (ALUCtl[1]) ? ~B : B;

    assign LEDR[0] = Zero;
    assign LEDR[1] = Overflow;
    assign LEDR[2] = Cout;

endmodule
