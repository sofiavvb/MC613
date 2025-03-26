`timescale 1ns / 1ps  // Define a unidade de tempo e precisão

module ledshift_tb;

    // Entradas do módulo ledshift
    reg [3:0] KEY;               // Botões de entrada
    reg CLOCK_50;                // Sinal de clock

    // Saídas do módulo ledshift
    wire [9:0] LEDR;             // LEDs de saída

    // Instanciando o módulo ledshift
    ledshift uut (
        .LEDR(LEDR),         // Saída LEDs
        .KEY(KEY),           // Entradas dos botões
        .CLOCK_50(CLOCK_50)  // Entrada de clock
    );

    // Gerador de clock
    always begin
        CLOCK_50 = 0; #10;  // Gera um sinal de clock com período de 20ns
        CLOCK_50 = 1; #10;
    end

    // Sequência de testes
    initial begin
        // Inicializa as variáveis
        KEY = 4'b1111;  // Inicializa todos os botões como "não pressionados"
        
        // Exibe o valor inicial dos LEDs
        $display("Inicializando os LEDs: %b", LEDR);
        
        // Teste 1: Pressionando KEY[0] (simula a borda de subida)
        #20;  // Aguarda 20ns para o clock
        KEY[0] = 0;  // Simula o pressionamento do botão KEY[0]
        #20;  // Aguarda mais 20ns
        KEY[0] = 1;  // Solta o botão KEY[0]

        // Teste 2: Pressionando KEY[3] (simula a borda de subida)
        #20;  // Aguarda 20ns para o clock
        KEY[3] = 0;  // Simula o pressionamento do botão KEY[3]
        #20;  // Aguarda mais 20ns
        KEY[3] = 1;  // Solta o botão KEY[3]
        
        // Teste 3: Observando o deslocamento dos LEDs
        #100;  // Aguarda 100ns para observar o comportamento

        // Teste 4: Pressionando novamente KEY[0] (outro deslocamento)
        #20;
        KEY[0] = 0;  // Pressionando o botão KEY[0]
        #20;
        KEY[0] = 1;  // Soltando o botão KEY[0]
        
        // Teste 5: Pressionando novamente KEY[3] (outro deslocamento)
        #20;
        KEY[3] = 0;  // Pressionando o botão KEY[3]
        #20;
        KEY[3] = 1;  // Soltando o botão KEY[3]

        // Teste 6: Finalizando os testes
        #100;  // Aguarda mais 100ns para observação final
        $stop;  // Interrompe a simulação
    end

endmodule
