
/*
- Como você calcula o tamanho em bytes da capacidade sua cache?
A capacidade útil da cache é calculada pelo número de linhas multiplicado pelo tamanho dos dados em cada linha, 
nesse caso temos 16 linhas e cada pode armazenar 32 bits(4 bytes),portanto, a capacidade útil é de 64 bytes.

- Qual o tamanho total da sua cache em bytes?  
Cada linha tem 1 bit (valid), 10 bits (tag) e 32 bits (data) = 43 bits por linha, portanto, o tamanho total será dado por:
16 linhasX43 bits = 688 bits/8 = 86 bytes

Qual o aproveitamento de espaço da sua cache (capacidade / espaço total)?
64 bytes úteis/86 bytes totais = 74.4%
*/

module inner_cache #(
  parameter DATA_WIDTH   = 32,
  parameter ADDR_WIDTH   = 16,
  parameter TAG_WIDTH    = 10,
  parameter OFFSET_WIDTH = 2
)(
  input  logic clk,
  input  logic [ADDR_WIDTH-1:0] addr,
  input  logic [DATA_WIDTH-1:0] data_in,
  input  logic write,
  output logic [DATA_WIDTH-1:0] data_out,
  output logic hit
);

  localparam INDEX_WIDTH  = ADDR_WIDTH - TAG_WIDTH - OFFSET_WIDTH;
  localparam CACHE_LINES  = 1 << INDEX_WIDTH; // shifta o 1 INDEX_WIDTH vezes porque o numero de linhas sempre e 2 elevado a esse numero

  // estrutura da cache
  logic [CACHE_LINES-1:0] valid;
  logic [TAG_WIDTH-1:0] tags[CACHE_LINES-1:0];
  logic [DATA_WIDTH-1:0] datas[CACHE_LINES-1:0];

  // Divisão do endereço
  logic [TAG_WIDTH-1:0] tag;
  logic [INDEX_WIDTH-1:0] index;

  assign tag   = addr[ADDR_WIDTH-1 -: TAG_WIDTH];
  assign index = addr[OFFSET_WIDTH + INDEX_WIDTH - 1 -: INDEX_WIDTH];

  initial begin
    integer i;
    for (i = 0; i < CACHE_LINES; i++) begin
      valid[i] = 0;
      tags[i] = 0;
      datas[i] = 0;
    end
  end

  // Leitura combinacional
  always_comb begin
    if (valid[index] && tags[index] == tag && !write) begin
      hit = 1;
      data_out = datas[index];
    end else begin
      hit = 0;
      data_out = '0;
    end
  end

  // Escrita sequencial
  always_ff @(posedge clk) begin
    if (write) begin
      valid[index] <= 1;
      tags[index]  <= tag;
      datas[index] <= data_in;
    end
  end

endmodule

