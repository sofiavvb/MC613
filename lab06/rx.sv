// modulo receptor UART

module rx(
    input logic clk,
    input logic rx,
    input logic tick,
    output logic [7:0] data_out,
    output logic done
);

    logic [3:0] bit_cnt;
    logic [10:0] shift_reg;
    logic receiving = 0;

    reg [2:0] edge_counter;
    logic negedge_tick;

    assign negedge_tick = edge_counter[2] & !edge_counter[1]; 

    always_ff @(posedge clk) begin
        if (!receiving && !rx) begin
            receiving <= 1;
            bit_cnt <= 0;
            done <= 0;
            edge_counter <=0;
        end else begin 
            edge_counter <= {edge_counter[1:0], tick};
            if (tick && receiving) begin
                shift_reg <= {rx, shift_reg[10:1]};
                bit_cnt <= bit_cnt + 1;

                if (bit_cnt == 10) begin
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
    end
endmodule
