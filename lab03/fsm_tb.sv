module fsm_tb;
    logic clk;
    logic rst;
    logic r50;
    logic r100;
    logic r200;
    logic cafe;
    logic t50;
    logic t100;
    logic t200;
    logic [3:0] state;

    fsm dut (
        .clk(clk),
        .rst(rst),
        .r50(r50),
        .r100(r100),
        .r200(r200),
        .cafe(cafe),
        .t50(t50),
        .t100(t100),
        .t200(t200),
        .state(state)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // clock de 10 unidades de tempo (5 alto e 5 baixo)
    end

    initial begin //testes

        $dumpfile("fsm_tb.vcd");
        $dumpvars(0, fsm_tb);

        rst = 1; //inicializa
        r50 = 0;
        r100 = 0;
        r200 = 0;
        
        #10; 

        rst = 0; 
        #10;
        
        r50 = 1; //insere 0,5
        #10;
        r50 = 0;
        #10;

        r100 = 1; //insere 1
        #10;
        r100 = 0;
        #10;

        r200 = 1; //insere 2
        #10;
        r200 = 0;
        #10;

        r100 = 1; //insere 1
        #10;
        r100 = 0;
        #10;

        r100 = 1; //insere 0,5
        #10;
        r100 = 0;
        #10;

        r200 = 1; //insere 0,5
        #10;
        r200 = 0;
        #10;

        $finish; //final
    end

    // Monitorando as saídas
    initial begin
        $monitor("Tempo: %0t | Estado: %b | Cafe: %b | T50: %b | T100: %b | T200: %b", 
                  $time, state, cafe, t50, t100, t200);
    end

endmodule


