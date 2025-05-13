// modulo receptor UART

module rx(
    input logic clk,
    input logic tick,
    input logic rx,
    output logic [7:0] data_out,
    output logic done
);

    logic [3:0] bit_cnt;
    logic [9:0] shift_reg;
    logic receiving;

    always_ff @(posedge clk) begin
        if (!receiving && !rx) begin
            receiving <= 1;
            bit_cnt <= 0;
        end else if (tick && receiving) begin
            shift_reg <= {rx, shift_reg[9:1]};
            bit_cnt <= bit_cnt + 1;

            if (bit_cnt == 9) begin
                receiving <= 0;
                data_out <= shift_reg[8:1];
                done <= 1;
            end else begin
                done <= 0;
            end
        end else begin
            done <= 0;
        end
    end
endmodule