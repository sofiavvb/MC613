module dec_7seg (
    input  logic [6:0] bin,  
    output logic [6:0] segs_dezena,
    output logic [6:0] segs_unidade
);
    logic [3:0] dezena, unidade;

    always_comb begin
        case (bin)
            7'd0:  begin dezena = 0; unidade = 0; end
            7'd1:  begin dezena = 0; unidade = 1; end
            7'd2:  begin dezena = 0; unidade = 2; end
            7'd3:  begin dezena = 0; unidade = 3; end
            7'd4:  begin dezena = 0; unidade = 4; end
            7'd5:  begin dezena = 0; unidade = 5; end
            7'd6:  begin dezena = 0; unidade = 6; end
            7'd7:  begin dezena = 0; unidade = 7; end
            7'd8:  begin dezena = 0; unidade = 8; end
            7'd9:  begin dezena = 0; unidade = 9; end
            7'd10: begin dezena = 1; unidade = 0; end
            7'd11: begin dezena = 1; unidade = 1; end
            7'd12: begin dezena = 1; unidade = 2; end
            7'd13: begin dezena = 1; unidade = 3; end
            7'd14: begin dezena = 1; unidade = 4; end
            7'd15: begin dezena = 1; unidade = 5; end
            7'd16: begin dezena = 1; unidade = 6; end
            7'd17: begin dezena = 1; unidade = 7; end
            7'd18: begin dezena = 1; unidade = 8; end
            7'd19: begin dezena = 1; unidade = 9; end
            7'd20: begin dezena = 2; unidade = 0; end
            7'd21: begin dezena = 2; unidade = 1; end
            7'd22: begin dezena = 2; unidade = 2; end
            7'd23: begin dezena = 2; unidade = 3; end
            7'd24: begin dezena = 2; unidade = 4; end
            7'd25: begin dezena = 2; unidade = 5; end
            7'd26: begin dezena = 2; unidade = 6; end
            7'd27: begin dezena = 2; unidade = 7; end
            7'd28: begin dezena = 2; unidade = 8; end
            7'd29: begin dezena = 2; unidade = 9; end
            7'd30: begin dezena = 3; unidade = 0; end
            7'd31: begin dezena = 3; unidade = 1; end
            7'd32: begin dezena = 3; unidade = 2; end
            7'd33: begin dezena = 3; unidade = 3; end
            7'd34: begin dezena = 3; unidade = 4; end
            7'd35: begin dezena = 3; unidade = 5; end
            7'd36: begin dezena = 3; unidade = 6; end
            7'd37: begin dezena = 3; unidade = 7; end
            7'd38: begin dezena = 3; unidade = 8; end
            7'd39: begin dezena = 3; unidade = 9; end
            7'd40: begin dezena = 4; unidade = 0; end
            7'd41: begin dezena = 4; unidade = 1; end
            7'd42: begin dezena = 4; unidade = 2; end
            7'd43: begin dezena = 4; unidade = 3; end
            7'd44: begin dezena = 4; unidade = 4; end
            7'd45: begin dezena = 4; unidade = 5; end
            7'd46: begin dezena = 4; unidade = 6; end
            7'd47: begin dezena = 4; unidade = 7; end
            7'd48: begin dezena = 4; unidade = 8; end
            7'd49: begin dezena = 4; unidade = 9; end
            7'd50: begin dezena = 5; unidade = 0; end
            7'd51: begin dezena = 5; unidade = 1; end
            7'd52: begin dezena = 5; unidade = 2; end
            7'd53: begin dezena = 5; unidade = 3; end
            7'd54: begin dezena = 5; unidade = 4; end
            7'd55: begin dezena = 5; unidade = 5; end
            7'd56: begin dezena = 5; unidade = 6; end
            7'd57: begin dezena = 5; unidade = 7; end
            7'd58: begin dezena = 5; unidade = 8; end
            7'd59: begin dezena = 5; unidade = 9; end
            7'd60: begin dezena = 6; unidade = 0; end
            7'd61: begin dezena = 6; unidade = 1; end
            7'd62: begin dezena = 6; unidade = 2; end
            7'd63: begin dezena = 6; unidade = 3; end
            7'd64: begin dezena = 6; unidade = 4; end
            7'd65: begin dezena = 6; unidade = 5; end
            7'd66: begin dezena = 6; unidade = 6; end
            7'd67: begin dezena = 6; unidade = 7; end
            7'd68: begin dezena = 6; unidade = 8; end
            7'd69: begin dezena = 6; unidade = 9; end
            7'd70: begin dezena = 7; unidade = 0; end
            7'd71: begin dezena = 7; unidade = 1; end
            7'd72: begin dezena = 7; unidade = 2; end
            7'd73: begin dezena = 7; unidade = 3; end
            7'd74: begin dezena = 7; unidade = 4; end
            7'd75: begin dezena = 7; unidade = 5; end
            7'd76: begin dezena = 7; unidade = 6; end
            7'd77: begin dezena = 7; unidade = 7; end
            7'd78: begin dezena = 7; unidade = 8; end
            7'd79: begin dezena = 7; unidade = 9; end
            7'd80: begin dezena = 8; unidade = 0; end
            7'd81: begin dezena = 8; unidade = 1; end
            7'd82: begin dezena = 8; unidade = 2; end
            7'd83: begin dezena = 8; unidade = 3; end
            7'd84: begin dezena = 8; unidade = 4; end
            7'd85: begin dezena = 8; unidade = 5; end
            7'd86: begin dezena = 8; unidade = 6; end
            7'd87: begin dezena = 8; unidade = 7; end
            7'd88: begin dezena = 8; unidade = 8; end
            7'd89: begin dezena = 8; unidade = 9; end
            7'd90: begin dezena = 9; unidade = 0; end
            7'd91: begin dezena = 9; unidade = 1; end
            7'd92: begin dezena = 9; unidade = 2; end
            7'd93: begin dezena = 9; unidade = 3; end
            7'd94: begin dezena = 9; unidade = 4; end
            7'd95: begin dezena = 9; unidade = 5; end
            7'd96: begin dezena = 9; unidade = 6; end
            7'd97: begin dezena = 9; unidade = 7; end
            7'd98: begin dezena = 9; unidade = 8; end
            7'd99: begin dezena = 9; unidade = 9; end
            default: begin dezena = 10; unidade = 10; end
        endcase
    end

    always_comb begin
        case (unidade)
            4'd0: segs_unidade = ~7'b0111111;
            4'd1: segs_unidade = ~7'b0000110;
            4'd2: segs_unidade = ~7'b1011011;
            4'd3: segs_unidade = ~7'b1001111;
            4'd4: segs_unidade = ~7'b1100110;
            4'd5: segs_unidade = ~7'b1101101;
            4'd6: segs_unidade = ~7'b1111101;
            4'd7: segs_unidade = ~7'b0000111;
            4'd8: segs_unidade = ~7'b1111111;
            4'd9: segs_unidade = ~7'b1101111;
            default: segs_unidade = 7'b1111111;
        endcase
    end

    always_comb begin
        case (dezena)
            4'd0: segs_dezena = ~7'b0111111;
            4'd1: segs_dezena = ~7'b0000110;
            4'd2: segs_dezena = ~7'b1011011;
            4'd3: segs_dezena = ~7'b1001111;
            4'd4: segs_dezena = ~7'b1100110;
            4'd5: segs_dezena = ~7'b1101101;
            4'd6: segs_dezena = ~7'b1111101;
            4'd7: segs_dezena = ~7'b0000111;
            4'd8: segs_dezena = ~7'b1111111;
            4'd9: segs_dezena = ~7'b1101111;
            default: segs_dezena = 7'b1111111;
        endcase
    end
endmodule
