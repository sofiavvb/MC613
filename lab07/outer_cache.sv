module outer_cache (
    input logic clk,
    input logic rst,

    input logic [15:0] upper_addr_in,
    output logic [15:0] upper_data_out,
    output logic upper_hit,

    output logic [15:0] lower_addr_out,
    input logic [15:0] lower_data_in,
    input logic lower_hit,
    output logic [15:0] lower_data_out,
    output logic lower_write
);
    logic [15:0] addr_reg;
    logic [15:0] data_reg;

    logic [15:0] inner_data_out;
    logic inner_hit;

    inner_cache inner_cache_inst (
        .clk(clk),
        .rst(rst),
        .addr_in(addr_reg),
        .data_out(inner_data_out),
        .hit(inner_hit)
    );

    enum logic [1:0] {IDLE, WAIT_LOWER, UPDATE_CACHE} state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            upper_data_out <= 16'b0;
            upper_hit <= 1'b0;
            lower_addr_out <= 16'b0;
            lower_write <= 1'b0;
            addr_reg <= 16'b0;
            data_reg <= 16'b0;
        end else begin
            case (state)
                IDLE: begin
                    addr_reg <= upper_addr_in;
                    if (inner_hit) begin
                        upper_data_out <= inner_data_out;
                        upper_hit <= 1'b1;
                        state <= IDLE;
                    end else begin
                        lower_addr_out <= upper_addr_in;
                        upper_hit <= 1'b0;
                        state <= WAIT_LOWER;
                    end
                end
                WAIT_LOWER: begin
                    if (lower_hit) begin
                        data_reg <= lower_data_in;
                        state <= UPDATE_CACHE;
                    end
                end
                UPDATE_CACHE: begin
                    lower_data_out <= data_reg;
                    lower_write <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
