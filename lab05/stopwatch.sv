module stopwatch(
    input logic clk,
    input logic rst,
    output logic clk_seg,
);
    logic [18:0] counter;
    logic enable;

    //dividir o clock para pegar 1 cent de segundo
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            enable <= 0;
        end else begin
            if (counter == 499_999) begin
                enable <= 1;
                counter <= 0;
            end else begin
                enable <= 0;
                counter <= counter + 1;
            end
        end
    end

    // Contadores
    logic [6:0] centesimos;
    logic [5:0] segundos;
    logic [6:0] minutos;

    always_ff @(posedge clk) begin 
        if(enable == 1) begin
            if(centesimos == 99) begin
                centesimos <= 0;
                if (segundos == 59) begin
                    segundos <= 0;
                    minutos <= minutos + 1;
                end else begin
                    segundos <= segundos + 1;
                end 
            end else begin
                centesimos <= centesimos + 1; 
            end
        end
    end

endmodule
