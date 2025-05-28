`timescale 1ns/1ps

module cache_hierarchy_tb;

  localparam DATA_WIDTH   = 32;
  localparam ADDR_WIDTH   = 16;
  localparam TAG_WIDTH_L1 = 10;
  localparam TAG_WIDTH_L2 = 6;
  localparam OFFSET_WIDTH = 2;

  logic clk;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] cpu_data;
  logic start, ready;

  always #5 clk = ~clk;
  initial clk = 0;

  ///////////////////////////
  // DRAM com atraso
  ///////////////////////////
  logic [ADDR_WIDTH-1:0] dram_addr;
  logic [DATA_WIDTH-1:0] dram_data;
  logic dram_read;
  logic dram_ready;

  localparam DRAM_DELAY = 100;
  logic [$clog2(DRAM_DELAY):0] dram_counter = 0;
  logic [DATA_WIDTH-1:0] dram_mem [0:2**ADDR_WIDTH-1];

  always_ff @(posedge clk) begin
    if (dram_read && dram_counter == 0) begin
      dram_counter <= 1;
    end else if (dram_counter != 0) begin
      dram_counter <= dram_counter + 1;
      if (dram_counter == DRAM_DELAY) begin
        dram_data <= {dram_addr, 16'b0};
        dram_ready <= 1;
        dram_counter <= 0;
      end
    end else begin
      dram_ready <= 0;
    end
  end

  ///////////////////////////
  // Instâncias de L2 e L1
  ///////////////////////////

  logic [DATA_WIDTH-1:0] l2_data_out;
  logic l2_hit;
  logic l2_start, l2_ready;

  outer_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH_L2),
    .OFFSET_WIDTH(OFFSET_WIDTH),
    .CACHE_DELAY(20)
  ) L2 (
    .clk(clk),
    .start(l2_start),
    .addr(addr),
    .data_out(l2_data_out),
    .hit(l2_hit),
    .ready(l2_ready),
    .C_DATA_IN(),
    .C_WRITE(),
    .MEM_DATA(dram_data),
    .MEM_READY(dram_ready),
    .MEM_ADDR(dram_addr),
    .MEM_READ(dram_read)
  );

  logic [DATA_WIDTH-1:0] l1_data_out;
  logic l1_hit;
  logic l1_start, l1_ready;

  outer_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH_L1),
    .OFFSET_WIDTH(OFFSET_WIDTH),
    .CACHE_DELAY(5)
  ) L1 (
    .clk(clk),
    .start(l1_start),
    .addr(addr),
    .data_out(l1_data_out),
    .hit(l1_hit),
    .ready(l1_ready),
    .C_DATA_IN(),
    .C_WRITE(),
    .MEM_DATA(l2_data_out),
    .MEM_READY(l2_ready),
    .MEM_ADDR(addr),
    .MEM_READ(l2_start)
  );

  ///////////////////////////
  // Simulação CPU com contador de tempo
  ///////////////////////////
  initial begin
    start = 0;
    addr  = 0;
    repeat (3) @(posedge clk);

    automatic int test_addrs [0:7] = '{
      16'h0000, 16'h0004, 16'h0100, 16'h0200,
      16'h0000, 16'h0100, 16'h0300, 16'h0004
    };

    foreach (test_addrs[i]) begin
      addr = test_addrs[i];
      start = 1;
      l1_start = 1;

      int cycles = 0;
      @(posedge clk);
      start = 0;
      l1_start = 0;

      // Espera resposta e conta ciclos
      while (!l1_ready) begin
        @(posedge clk);
        cycles++;
      end

      string origem;
      if (l1_hit)
        origem = "L1";
      else if (l2_hit)
        origem = "L2";
      else
        origem = "DRAM";

      $display("CPU: addr = %h, data = %h, origem = %s, tempo = %0d ciclos",
               addr, l1_data_out, origem, cycles);
      @(posedge clk);
    end

    $finish;
  end

endmodule
