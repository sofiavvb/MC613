// modulo divisor de clock sabendo que 50 MHz / 9600 = 5208

module div_clock #(parameter DIV = 5208) (
    input logic clk,
    input logic rst,
    output logic pulse
);

    logic [$clog2(DIV)-1:0] counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            pulse <= 0;
        end else if (counter == DIV / 2) begin
            counter <= 0;
            pulse <= 1;
        end else begin
            counter <= counter + 1;
            pulse <= 0;
        end
    end

endmodule