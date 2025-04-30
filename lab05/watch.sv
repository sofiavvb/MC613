module watch(
    input logic clk,
    output logic [5:0] segundos;
    output logic [5:0] minutos;
    output logic [4:0] horas;
    output logic blink;
);

    logic [25:0] counter;
    logic enable;
    logic [1:0] mode;  // 2 bits → 0 a 3 (normal, hora, minuto, segundo)
    input logic [5:0] val; //valor para acertar o relogio



    // Divisor de clock: gera pulso de 1s
    always_ff @(posedge clk) begin
        if begin
            if (counter == 49_999_999) begin
                enable <= 1;
                counter <= 0;
                blink <= ~blink;
            end else begin
                enable <= 0;
                counter <= counter + 1;
            end
        end
    end

    // Contador de tempo (hora:min:seg)
    always_ff @(posedge clk) begin 
        if (enable == 1) begin
            if (segundos == 59) begin
                segundos <= 0;
                if (minutos == 59) begin
                    minutos <= 0;
                    if (horas == 23)
                        horas <= 0;
                    else
                        horas <= horas + 1;
                end else begin
                    minutos <= minutos + 1;
                end 
            end else begin
                segundos <= segundos + 1; 
            end
        end
    end

    always_ff @(posedge clk) begin
        if (mode_btn) begin  // KEY[2]
            mode <= (mode == 2'b11) ? 2'b00 : mode + 1;
        end
    end

    // Lógica para ajuste do relógio
    always_ff @(posedge clk) begin
        if (mode == 2'b01) begin //horas
           if (sw_val <= 6'd23) horas <= sw_val;
        end else if (mode == 2'b10) begin // min
            if (sw_val <= 6'd59) min <= sw_val;
        end else if (mode == 2'b11) begin // seg
            if (sw_val <= 6'd59) seg <= sw_val;
        end
    end

endmodule   