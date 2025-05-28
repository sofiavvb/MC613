module cache_tb;

  localparam DATA_WIDTH   = 32;
  localparam ADDR_WIDTH   = 16;
  localparam TAG_WIDTH    = 10;
  localparam OFFSET_WIDTH = 2;

  logic clk = 0;
  logic write;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  logic hit;

  always #5 clk = ~clk;

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
    $display("Time\tWrite\tAddr (binário)\t\tData_in\t\tHit\tData_out");

    write = 1;
    addr = 16'hABCD;
    data_in = 32'hDEADBEEF;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);
    #10;
    // escreve
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera HIT)
    write = 0;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera MISS)
    addr = 16'hCB00;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera HIT)
    addr = 16'hABCD;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera MISS)
    addr = 16'hACCD;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // escreve
    write = 1;
    data_in = 32'hCAFEBABE;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera HIT)
    write = 0;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera MISS)
    addr = 16'hBCCD;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // escreve
    write = 1;
    data_in = 32'h12345678;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera MISS)
    write = 0;
    addr = 16'hACCD;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // (espera MISS)
    addr = 16'h3F3F;
    #10;
    $display("%0t\t%b\t%016b\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    $finish;
  end

endmodule
