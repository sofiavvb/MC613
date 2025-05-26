module cache_tb;

  // Parâmetros fixos (iguais aos do módulo)
  localparam DATA_WIDTH   = 32;
  localparam ADDR_WIDTH   = 16;
  localparam TAG_WIDTH    = 10;
  localparam OFFSET_WIDTH = 2;

  // Sinais
  logic clk = 0;
  logic write;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic hit;

  // Clock: 10 unidades de tempo (5 up, 5 down)
  always #5 clk = ~clk;

  // Instância do DUT
  inner_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH),
    .OFFSET_WIDTH(OFFSET_WIDTH)
  ) dut (
    .clk(clk),
    .addr(addr),
    .data_in(data_in),
    .write(write),
    .data_out(data_out),
    .hit(hit)
  );

  initial begin
    $display("Time\tWrite\tAddr\tData_in\t\tHit\tData_out");

    // Etapa 1: escrita em um endereco que nao tem nada ainda (Espera MISS)
    write = 1;
    addr = 16'hABCD;
    data_in = 32'hDEADBEEF;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 2: leitura do mesmo endereço (espera HIT)
    write = 0;
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 3: leitura de outro endereço que bate no mesmo índice mas com TAG diferente (espera MISS)
    // Como temos TAG_WIDTH=10, INDEX_WIDTH=4 (pois 16 - 10 - 2 = 4)
    // Precisamos mudar a TAG mas manter o mesmo INDEX. INDEX está em bits [5:2]
    // Mantemos index, mudamos TAG
    addr = 16'hCB00;  // Mesmo index, outra tag
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 4: volta para o endereço original (espera HIT)
    addr = 16'hABCD;
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    $finish;
  end

endmodule
