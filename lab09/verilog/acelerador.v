module acelerador (
    input wire clk,
    input wire reset,

    input wire start,
    output reg done,

    input wire [7:0] altura,
    input wire [7:0] largura,

    input wire [7:0] pixel_in,
    output reg [15:0] read_addr,
    output reg read_en,

    output reg [7:0] pixel_out,
    output reg [15:0] write_addr,
    output reg write_en
);

    typedef enum logic [2:0] {
        IDLE,
        PREPARE,
        READ_PIXELS,
        CALC,
        WRITE,
        NEXT,
        FINISHED
    } estado_t;

    estado_t estado = IDLE;

    reg [7:0] x, y;  
    reg [7:0] linha[0:2][0:2]; 

    reg [3:0] pixel_index;

    wire [15:0] addr_pixel;
    assign addr_pixel = (y + (pixel_index / 3) - 1) * largura + (x + (pixel_index % 3) - 1);

    always @(posedge clk) begin
        if (reset) begin
            estado <= IDLE;
            done <= 0;
            read_en <= 0;
            write_en <= 0;
        end else begin
            case (estado)
                IDLE: begin
                    done <= 0;
                    if (start) begin
                        x <= 1;
                        y <= 1;
                        pixel_index <= 0;
                        estado <= PREPARE;
                    end
                end

                PREPARE: begin
                    read_addr <= (y - 1) * largura + (x - 1);
                    read_en <= 1;
                    pixel_index <= 0;
                    estado <= READ_PIXELS;
                end

                READ_PIXELS: begin
                    read_en <= 0;
                    linha[pixel_index / 3][pixel_index % 3] <= pixel_in;
                    pixel_index <= pixel_index + 1;

                    if (pixel_index < 8) begin
                        read_addr <= (y + (pixel_index + 1) / 3 - 1) * largura + (x + (pixel_index + 1) % 3 - 1);
                        read_en <= 1;
                    end else begin
                        estado <= CALC;
                    end
                end

                CALC: begin
                    // Gx kernel: [-1 0 1; -2 0 2; -1 0 1]
                    // Gy kernel: [-1 -2 -1; 0 0 0; 1 2 1]
                    integer gx, gy;
                    gx = -linha[0][0] + linha[0][2]
                       - 2 * linha[1][0] + 2 * linha[1][2]
                       - linha[2][0] + linha[2][2];

                    gy = -linha[0][0] - 2 * linha[0][1] - linha[0][2]
                       + linha[2][0] + 2 * linha[2][1] + linha[2][2];

                    integer magnitude;
                    magnitude = (gx < 0 ? -gx : gx) + (gy < 0 ? -gy : gy);
                    if (magnitude > 255) magnitude = 255;

                    pixel_out <= magnitude[7:0];
                    write_addr <= y * largura + x;
                    write_en <= 1;
                    estado <= WRITE;
                end

                WRITE: begin
                    write_en <= 0;
                    estado <= NEXT;
                end

                NEXT: begin
                    if (x + 1 < largura - 1)
                        x <= x + 1;
                    else begin
                        x <= 1;
                        if (y + 1 < altura - 1)
                            y <= y + 1;
                        else
                            estado <= FINISHED;
                    end
                    pixel_index <= 0;
                    estado <= PREPARE;
                end

                FINISHED: begin
                    done <= 1;
                    estado <= IDLE;
                end
            endcase
        end
    end

endmodule
