module outer_cache #(
  parameter DATA_WIDTH   = 32,
  parameter ADDR_WIDTH   = 16,
  parameter TAG_WIDTH    = 10,
  parameter OFFSET_WIDTH = 2
)(
  input  logic clk,
    //interface com o nivel anterior
  input  logic [ADDR_WIDTH-1:0] c_addr_in,
  output logic [DATA_WIDTH-1:0] c_data_out,
  output logic c_hit,
  input  logic [DATA_WIDTH-1:0] c_data_in, 
  input  logic c_write,

  //interface com próximo nível 
  output logic [ADDR_WIDTH-1:0] m_addr_out,
  input  logic [DATA_WIDTH-1:0] m_data_in,
  input  logic                  m_hit,
  output logic [DATA_WIDTH-1:0] m_data_out,
  output logic                  m_write
);

  logic [DATA_WIDTH-1:0] data_l1;
  logic hit_l1;

  //(L1)
  inner_cache #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .TAG_WIDTH(TAG_WIDTH),
    .OFFSET_WIDTH(OFFSET_WIDTH)
  ) cache_inst (
    .clk(clk),
    .addr(c_addr_in),
    .data_in(m_data_in),
    .write(m_hit),
    .data_out(data_l1),
    .hit(hit_l1)
  );

  // Controle externo
  always_comb begin
    if (hit_l1) begin
      c_hit       = 1;
      c_data_out  = data_l1;
      m_addr_out  = '0;
      m_write     = 0;
      m_data_out  = '0;
    end else begin
      c_hit       = m_hit;
      c_data_out  = m_data_in;
      m_addr_out  = c_addr_in;
      m_write     = 0;
      m_data_out  = '0;
    end
  end

endmodule
