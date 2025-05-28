
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

/*
  // logica de leitura
  always_comb begin
    if (valid[index] && tags[index] == tag) begin
      hit = 1;
      data_out = datas[index];
    end else begin
      hit = 0;
      data_out = '0;
    end
  end

  // logica de escrita e reset síncrono
  always_ff @(posedge clk) begin
    if (rst) begin
      integer i;
      for (i = 0; i < CACHE_LINES; i++) begin
        valid[i] <= 0;
        tags[i]  <= 0;
        datas[i] <= 0;
      end
    end else if (write) begin
      valid[index] <= 1;
      tags[index]  <= tag;
      datas[index] <= data_in;
    end
  end
endmodule
*/


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


// module INNER_CACHE #(
//   parameter DATA_WIDTH   = 32,  // Tamanho em bits dos dados
//   parameter ADDR_WIDTH   = 16,  // Tamanho em bits dos endereços recebidos
//   parameter TAG_WIDTH    = 10,  // Tamanho da tag
//   parameter OFFSET_WIDTH = 2    // Bits de offset (não usados nesta implementação)
// )(
//   input  logic clk, 
//   input  logic [ADDR_WIDTH-1:0] addr,  // Substituindo struct por arrays separados
//   input  logic [DATA_WIDTH-1:0] data_in,
//   input  logic  write,
//   output logic [DATA_WIDTH-1:0] data_out,
//   output logic hit
// );
//     // ADDRESS (16 bits):  [  TAG    /   INDEX    /  OFFSET]
//     localparam INDEX_WIDTH = ADDR_WIDTH - TAG_WIDTH - OFFSET_WIDTH;
//     localparam cache_lines  = 1 << INDEX_WIDTH;

//     // Cache line: {valid, tag, data}
//     typedef struct packed {
//         logic valid;
//         logic [TAG_WIDTH-1:0] tag;
//         logic [DATA_WIDTH-1:0] data;
//     } cache_line_t;

//     // Cache: array de cache_lines (matriz)
//     cache_line_t cache [0:cache_lines-1];
    
//     // Declarando os sinais 
//     logic [TAG_WIDTH-1:0]   tag;
//     logic [INDEX_WIDTH-1:0] index;

//     // Dividindo o endereço em tag e index 
//     assign tag   = addr[ADDR_WIDTH-1 -: TAG_WIDTH]; //pega tag_width bits começando do bit addr_width - 1  e indo para a direita.
//     assign index = addr[OFFSET_WIDTH + INDEX_WIDTH - 1 -: INDEX_WIDTH]; //pega index_width bits começando do bit offset_width + index_width - 1 e indo para a direita.

//     initial begin
//         integer i;
//         for (i = 0; i < cache_lines; i++) begin
//             cache[i].valid = 0;
//             cache[i].tag   = 0;
//             cache[i].data  = 0;
//         end
//     end

//     always_comb begin
//         if (cache[index].valid && cache[index].tag == tag) begin
//             hit = 1;
//             data_out = cache[index].data;
//         end else begin
//             hit = 0;
//             data_out = '0; // retorna 0 no caso de miss
//         end
//   end

//     // Lógica de escrita
//     always_ff @(posedge clk) begin
//         if (write) begin
//             cache[index].valid <= 1;
//             cache[index].tag   <= tag;
//             cache[index].data  <= data_in;
//         end
//     end


// endmodule
