// modulo transmissor UART

module tx(
    input  logic clk,        
    input  logic tick,       // Tick de baud rate (ex: 9600Hz)
    input  logic send,
    input logic rst,       // Sinal para iniciar transmissão
    input  logic [7:0]  data_in, // Byte de dados
    output logic tx,         // Linha TX
    output logic busy        // Indica transmissão em andamento
);

    logic [3:0] bit_cnt;
    logic [10:0] shift_reg;  // Linha ociosa = 1
    logic sending;

    // Função para calcular paridade par
    function logic calc_parity(input [7:0] data);
        calc_parity = ^data;  // XOR de todos os bits e inverte (paridade par)
    endfunction

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            tx        <= 1; // Linha idle
            busy      <= 0;
            sending   <= 0;
            bit_cnt   <= 0;
            shift_reg <= 0;

        end else if (send && !sending) begin
            shift_reg <= {1'b1,  calc_parity(data_in), data_in, 1'b0}; // STOP | PAR | DATA | START
            bit_cnt   <= 0;
            sending   <= 1;
            busy      <= 1;
            tx        <= 0; // START bit
        end
        else if (tick && sending) begin
            tx <= shift_reg[0];
            shift_reg <= shift_reg >> 1;
            bit_cnt   <= bit_cnt + 1;

            if (bit_cnt == 10) begin
                sending <= 0;
                busy    <= 0;
                tx      <= 1; 
            end
        end else if (!sending) begin
            tx <= 1; // nao enviando
        end
    end


endmodule   