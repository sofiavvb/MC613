module multiplier #(
    parameter int N = 5 
)(
    input logic clk,
    input logic set,
    input logic [N-1:0] a, // multiplicando
    input logic [N-1:0] b, // multiplicador
    output logic [2*N-1:0] r // resultado
); 

    logic [2*N-1:0] A_ext;      // A extendido para poder shiftar (multiplicando)
    logic [N-1:0] B;            // multiplicador

    always_ff @(posedge clk) begin 
        if(set) begin
            r <= 0;
            A_ext <= a; //ele joga na parte baixa
            B <= b;  
        end else begin 
            if(B[0] == 1) begin
                r <= r + A_ext;
            end
            A_ext <= A_ext << 1; 
            B <= B >> 1;  
        end
    end
endmodule