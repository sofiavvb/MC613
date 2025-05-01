module dec_7seg (
    input  logic [3:0] bin,
    output logic [6:0] segs
);
    always_comb begin
        case (bin)
            4'd0: segs = ~7'b0111111; // 0
            4'd1: segs = ~7'b0000110; // 1
            4'd2: segs = ~7'b1011011; // 2
            4'd3: segs = ~7'b1001111; // 3
            4'd4: segs = ~7'b1100110; // 4
            4'd5: segs = ~7'b1101101; // 5
            4'd6: segs = ~7'b1111101; // 6
            4'd7: segs = ~7'b0000111; // 7
            4'd8: segs = ~7'b1111111; // 8
            4'd9: segs = ~7'b1101111; // 9
            default: segs = 7'b1111111; // tudo apagado
        endcase
    end
endmodule