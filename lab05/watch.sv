module watch(
    input logic clk,
    input logic [5:0] val,      // valor para acertar o relógio (SW[5:0])
    input logic mode_btn,       // botão para alternar o modo (KEY[2])
    output logic [5:0] segundos,
    output logic [5:0] minutos,
    output logic [4:0] horas,
    output logic blink
);
    logic mode_btn_antigo;
    logic [25:0] counter;
    logic enable;
    logic [1:0] mode;

    logic [5:0] seg_reg, min_reg;
    logic [4:0] hour_reg;

    assign segundos = seg_reg;
    assign minutos = min_reg;
    assign horas = hour_reg;

    // Divisor de clock
    always_ff @(posedge clk) begin
        if (counter == 49_999_999) begin
            enable <= 1;
            counter <= 0;
            blink <= ~blink;
        end else begin
            enable <= 0;
            counter <= counter + 1;
        end
    end

    // Alterna o modo
    always_ff @(posedge clk) begin
        mode_btn_antigo <= mode_btn;

        if (~mode_btn_antigo & mode_btn) begin // borda de subida
            mode <= (mode == 2'b11) ? 2'b00 : mode + 1;
        end
    end
    

    always_ff @(posedge clk) begin
        case (mode)
            2'b01: 
                if (val <= 6'd23) begin
                    hour_reg = val;
                end b  
            2'b10: 
                if (val <= 6'd59) begin
                    min_reg = val;
                end
            2'b11: 
                if (val <= 6'd59) begin
                    seg_reg = val;
                end
            default: if (enable) begin
                if (seg_reg => 59) begin
                    seg_reg = 0;
                    if (min_reg => 59) begin
                        min_reg = 0;
                        if (hour_reg => 23)
                            hour_reg = 0;
                        else
                            hour_reg = hour_reg + 1;
                    end else begin
                        min_reg = min_reg + 1;
                    end
                end else begin
                    seg_reg = seg_reg + 1;
                end
            end
        endcase
    end

endmodule
