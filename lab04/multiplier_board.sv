module multiplier_board (
    input logic [9:0] SW,
    input logic [3:0] KEY,
    input logic CLOCK_50,
    output logic [6:0] HEX2,  
    output logic [6:0] HEX1,  
    output logic [6:0] HEX0, 
);

    //sinais de controle
    logic [4:0] A, B, B_mul; 
    logic [9:0] R, A_mul;


    //inputs
    assign A = SW[9:5];
    assign B = SW[4:0];

    //multiplicador 
    multiplier multiplier (
       .clk(CLOCK_50),
       .set(~KEY[0]),
       .a(A),
       .b(B),
       .r(R) 
    );

    //outputs para seguimentos
    hex_7seg display0 (
        .bin(R[3:0]),
        .segs(HEX0)
    );

    hex_7seg display1 (
        .bin(R[7:4]),
        .segs(HEX1)
    );

    hex_7seg display2 (
        .bin({2'b0, R[9:8]}),
        .segs(HEX2)
    );


endmodule

