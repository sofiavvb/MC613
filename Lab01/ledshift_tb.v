`timescale 1ns/1ps

module ledshift_tb();
    reg [3:0] KEY;
    reg CLOCK_50;
    wire [9:0] LEDR;

    // Instanciando o módulo a ser testado
    ledshift uut (
        .LEDR(LEDR),
        .KEY(KEY),
        .CLOCK_50(CLOCK_50)
    );

    // Geração de clock usando always
    initial begin
        CLOCK_50 = 1'b0;
    end

	 always #2 CLOCK_50 = ~CLOCK_50;
	 
	 integer i;
	 
    // Teste principals
    initial begin
        $dumpfile("ledshift_tb.vcd"); // Arquivo de saída para waveform
        $dumpvars(0, ledshift_tb);    // Salvar variáveis no waveform

        // Inicialização
        KEY = 4'b1111; // Nenhuma tecla pressionada

		  for (i=0; i<10; i=i+1)
		  begin
				KEY[3] = 0; // Pressiona KEY[0] (movimento para direita)
				#20;
				KEY[3] = 1; // Solta KEY[0]
				#20;
		  end
		  for (i=0; i<10; i=i+1)
		  begin
				KEY[0] = 0; // Pressiona KEY[0] (movimento para direita)
				#20;
				KEY[0] = 1; // Solta KEY[0]
				#20;
		  end


		  
        $finish; // Finaliza a simulação
		  
    end

endmodule