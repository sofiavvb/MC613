module watch(
    input logic clk,
    input logic rst
);

    logic [25:0] counter;
    logic enable;

    logic [5:0] segundos;
    logic [5:0] minutos;
    logic [4:0] horas;

    // Divisor de clock: gera pulso de 1s
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            enable <= 0;
        end else begin
            if (counter == 49_999_999) begin
                enable <= 1;
                counter <= 0;
            end else begin
                enable <= 0;
                counter <= counter + 1;
            end
        end
    end

    // Contador de tempo (hora:min:seg)
    always_ff @(posedge clk or posedge rst) begin 
        if (rst) begin
            segundos <= 0;
            minutos <= 0;
            horas <= 0;
        end else if (enable == 1) begin
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

endmodule



