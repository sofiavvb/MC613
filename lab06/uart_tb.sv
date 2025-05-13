`timescale 1ns / 1ps

module uart_tb();

    // Parâmetros da UART
    parameter CLK_PERIOD = 20;        // 50 MHz => 20 ns por ciclo
    parameter BAUD_RATE = 9600;
    parameter BAUD_TICK = 104_166;    // Em ns: 1/9600 s ≈ 104.166 us

    // Sinais da UART
    logic clk = 0;
    logic rst = 1;
    logic send = 0;
    logic [7:0] tx_data = 8'h00;
    logic tx;
    logic rx;
    logic [7:0] rx_data;
    logic tx_busy;
    logic rx_done;

    // Conecta TX no RX internamente (loopback)
    assign rx = tx;

    // Instancia a UART
    uart uart_inst (
        .clk(clk),
        .rst(rst),
        .send(send),
        .tx_data(tx_data),
        .rx(rx),
        .tx(tx),
        .rx_data(rx_data),
        .tx_busy(tx_busy),
        .rx_done(rx_done)
    );

    // Gera clock de 50 MHz
    always #(CLK_PERIOD/2) clk = ~clk;

    // Tarefa para enviar um byte pela UART
    task send_byte(input [7:0] data);
        begin
            @(negedge clk);
            tx_data = data;
            send = 1;
            @(negedge clk);
            send = 0;

            // Espera a transmissão terminar
            wait (tx_busy == 0);
        end
    endtask

    // Simulação principal
    initial begin
        $display("Iniciando simulação UART...");
        $dumpfile("uart_tb.vcd");
        $dumpvars;

        // Reset
        #100;
        rst = 0;

        // Envia o byte 0xA5
        send_byte(8'hA5);
        $display("Byte enviado: 0xA5");

        // Espera o receptor sinalizar conclusão
        wait(rx_done == 1);
        @(negedge clk); // Espera um ciclo para estabilidade

        if (rx_data == 8'hA5) begin
            $display("SUCESSO! Byte recebido corretamente: %h", rx_data);
        end else begin
            $display("ERRO! Byte recebido: %h (esperado: A5)", rx_data);
        end

        #20000; // Espera extra para observação no GTKWave
        $finish;
    end

endmodule
