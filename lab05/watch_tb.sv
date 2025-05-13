`timescale 1ns/1ps

module watch_tb;

    logic clk;
    logic [5:0] val;
    logic mode_btn;
    logic [5:0] segundos;
    logic [5:0] minutos;
    logic [4:0] horas;
    logic blink;

    watch uut (
        .clk(clk),
        .val(val),
        .mode_btn(mode_btn),
        .segundos(segundos),
        .minutos(minutos),
        .horas(horas),
        .blink(blink)
    );

    //clock de 10ns
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        val = 0;
        mode_btn = 0;

        #100;

        //modo 1 - ajustar hora
        press_button();
        val = 6'd10; #20;  // tenta setar 10h
        #100;

        //modo 2 - ajustar minuto
        press_button();
        val = 6'd34; #20;  // tenta setar 34min
        #100;

        //modo 3 - ajustar segundo
        press_button();
        val = 6'd50; #20;  // tenta setar 50s
        #100;
        //contagem
        press_button();

        repeat (100_000_000) @(posedge clk);

        $display("Hora final: %0d:%0d:%0d", horas, minutos, segundos);

        $finish;
    end

    //tarefa para simular um clique no botão
    task press_button;
        begin
            mode_btn = 1;
            #20;
            mode_btn = 0;
            #20;
        end
    endtask

endmodule
