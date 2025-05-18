// modulo receptor UART

module rx(
    input logic clk,
    input logic rst,
    input logic rx,
    input logic tick,
    output logic [7:0] data_out,
    output logic done,
    output logic error
);

    logic [3:0] bit_counter; //contar quantos bits ja processamos dos dados
    logic [7:0] shift_reg;
    logic receiving;
    logic parity_check;

    always_ff @(posedge clk) begin
        if (rst) begin
            receiving <= 0;
            bit_counter <= 0;
            shift_reg <= 0;
            done <= 0;
            error <= 0;
        end else if (!receiving && !rx) begin
            receiving <= 1;
            parity_check <= 0;
            bit_counter <= 0;
            done <= 0;
        end else begin 
            if (tick && receiving) begin
                shift_reg <= {rx, shift_reg[7:1]};
                parity_check <= parity_check ^ rx; // XOR para verificar paridade
                bit_counter <= bit_counter + 1;

                if (bit_counter == 10) begin
                    receiving <= 0;
                    data_out <= shift_reg;
                    error <= (parity_check != rx); // Verifica paridade 
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
