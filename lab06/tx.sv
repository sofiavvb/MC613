// modulo transmissor UART

module tx(
    input logic clk,            
    input logic tick,           // pulso de X bits/s (usando 9600 bits/s)
    input logic send,           // 1 Start bit
    input logic [7:0] data_in,  // 8 bits de de dados
    output logic tx,            // TX de fato a ser transmitido
    output logic busy           // indicador de transmissao em andamento
);

    logic [3:0] bit_cnt;
    logic [9:0] shift_reg;      // Start(1) + 8 dados + parity + stop(1)
    logic sending;

    // Calcula bit de paridade par
    function logic calc_parity(input [7:0] data);
        calc_parity = ~^data;  // Paridade par (XOR de todos os bits e inverte)
    endfunction

    always_ff @(posedge clk) begin
        if (send && !sending) begin
            // Prepara os dados para envio: start(0), data, parity, stop(1)
            shift_reg <= {1'b1, calc_parity(data_in), data_in, 1'b0};
            bit_cnt <= 0;
            sending <= 1;
            busy <= 1;
        end else if (tick && sending) begin
            tx <= shift_reg[0];           // Envia LSB primeiro
            shift_reg <= shift_reg >> 1;  // Avança para o próximo bit
            bit_cnt <= bit_cnt + 1;

            if (bit_cnt == 9) begin       // 10 bits enviados (0..9)
                sending <= 0;
                busy <= 0;
                tx <= 1;                  // Linha ociosa
            end
        end
    end

    // Estado inicial
    initial begin
        tx = 1;
        busy = 0;
        sending = 0;
    end

endmodule