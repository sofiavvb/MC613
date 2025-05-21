module INNER_CACHE #(
  parameter DATA_WIDTH   = 32,  // Tamanho em bits dos dados
  parameter ADDR_WIDTH   = 16,  // Tamanho em bits dos endereços recebidos
  parameter TAG_WIDTH    = 10,  // Tamanho da tag
  parameter OFFSET_WIDTH = 2    // Bits de offset (não usados nesta implementação)
)(
  input  logic clk, 
  input  logic [ADDR_WIDTH-1:0] addr,
  input  logic [DATA_WIDTH-1:0] data_in,
  input  logic  write,
  output logic [DATA_WIDTH-1:0] data_out,
  output logic hit
);
    // ADDRESS (16 bits):  [  TAG    /   INDEX    /  OFFSET]
    localparam index_width = ADDR_WIDTH - TAG_WIDTH - OFFSET_WIDTH;
    localparam cache_lines  = 1 << index_width;

    // Cache line: {valid, tag, data}
    typedef struct packed {
        logic valid;
        logic [TAG_WIDTH-1:0] tag;
        logic [DATA_WIDTH-1:0] data;
    } cache_line_t;

    // Cache: array de cache_lines (matriz)
    cache_line_t cache [0:cache_lines-1];
    
    // Declarando os sinais 
    logic [TAG_WIDTH-1:0]   tag;
    logic [INDEX_WIDTH-1:0] index;

    // Dividindo o endereço em tag e index 
    assign tag   = addr[ADDR_WIDTH-1 -: TAG_WIDTH]; //pega tag_width bits começando do bit addr_width - 1  e indo para a direita.
    assign index = addr[OFFSET_WIDTH + INDEX_WIDTH - 1 -: INDEX_WIDTH]; //pega index_width bits começando do bit offset_width + index_width - 1 e indo para a direita.

    always_comb begin
        if (cache[index].valid && cache[index].tag == tag) begin
            hit = 1;
            data_out = cache[index].data;
        end else begin
            hit = 0;
            data_out = '0; // retorna 0 no caso de miss
        end
  end

    // Lógica de escrita
    always_ff @(posedge clk) begin
        if (write) begin
            cache[index].valid <= 1;
            cache[index].tag   <= tag;
            cache[index].data  <= data_in;
        end
    end


endmodule
