module cache_hierarchy_tb;

  // Parâmetros
  localparam DATA_WIDTH   = 32;
  localparam ADDR_WIDTH   = 16;
  localparam TAG_WIDTH_L1 = 10;
  localparam TAG_WIDTH_L2 = 8;
  localparam OFFSET_WIDTH = 2;

  // Sinais principais
  logic clk = 0;
  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_in = 0;
  logic [DATA_WIDTH-1:0] data_out;
  logic hit;
  logic write = 0;

  // Clock: 10 unidades de tempo
  always #5 clk = ~clk;

  // L1 <-> CPU
  logic [ADDR_WIDTH-1:0] l1_addr_in;
  logic [DATA_WIDTH-1:0] l1_data_out;
  logic l1_hit;

  // L1 <-> L2
  logic [ADDR_WIDTH-1:0] l1_to_l2_addr;
  logic [DATA_WIDTH-1:0] l1_to_l2_data_in;
  logic l1_to_l2_hit;
  logic [DATA_WIDTH-1:0] l1_to_l2_data_out;
  logic l1_to_l2_write;

  // L2 <-> ROM
  logic [ADDR_WIDTH-1:0] l2_to_rom_addr;
  logic [DATA_WIDTH-1:0] l2_to_rom_data;
  logic l2_to_rom_hit;
  logic [DATA_WIDTH-1:0] l2_to_rom_data_out;
  logic l2_to_rom_write;

  // Simulação da ROM com latência de 20 ciclos
  logic [DATA_WIDTH-1:0] rom [0:2**ADDR_WIDTH-1];
  logic [19:0] delay_counter = 0;
  logic [ADDR_WIDTH-1:0] rom_pending_addr;
  logic rom_waiting = 0;

  initial begin
    for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
      rom[i] = i * 16'h10;
    end
  end

  always_ff @(posedge clk) begin
    if (rom_waiting) begin
      if (delay_counter == 0) begin
        l2_to_rom_data <= rom[rom_pending_addr];
        l2_to_rom_hit <= 1;
        rom_waiting <= 0;
      end else begin
        delay_counter <= delay_counter - 1;
      end
    end else if (!l2_to_rom_hit) begin
      rom_pending_addr <= l2_to_rom_addr;
      delay_counter <= 19;
      rom_waiting <= 1;
    end
  end

  // Instância da cache L2
  outer_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH_L2),
    .OFFSET_WIDTH(OFFSET_WIDTH)
  ) l2 (
    .clk(clk),
    .c_addr_in(l1_to_l2_addr),
    .c_data_out(l1_to_l2_data_in),
    .c_hit(l1_to_l2_hit),
    .c_data_in(32'b0),
    .c_write(1'b0),
    .m_addr_out(l2_to_rom_addr),
    .m_data_in(l2_to_rom_data),
    .m_hit(l2_to_rom_hit),
    .m_data_out(l2_to_rom_data_out),
    .m_write(l2_to_rom_write)
  );

  // Instância da cache L1
  outer_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH_L1),
    .OFFSET_WIDTH(OFFSET_WIDTH)
  ) l1 (
    .clk(clk),
    .c_addr_in(addr),
    .c_data_out(data_out),
    .c_hit(hit),
    .c_data_in(32'b0),
    .c_write(write),
    .m_addr_out(l1_to_l2_addr),
    .m_data_in(l1_to_l2_data_in),
    .m_hit(l1_to_l2_hit),
    .m_data_out(l1_to_l2_data_out),
    .m_write(l1_to_l2_write)
  );

  // Estímulo (sem escrita real, apenas leitura)
  initial begin
    $display("Time\tWrite\tAddr\tData_in\t\tHit\tData_out");

    // Etapa 1: leitura de endereço que deve resultar em miss e buscar na ROM
    addr = 16'hABCD;
    #1 $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);
    #100;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 2: leitura do mesmo endereço (espera HIT em L1)
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 3: leitura com mesmo índice, mas tag diferente (espera MISS)
    addr = 16'hCB00;  // Mesmo índice, outra TAG
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    // Etapa 4: leitura de novo no primeiro endereço (espera HIT se L1 não foi sobrescrito)
    addr = 16'hABCD;
    #10;
    $display("%0t\t%b\t%h\t%h\t%b\t%h", $time, write, addr, data_in, hit, data_out);

    $finish;
  end

endmodule
