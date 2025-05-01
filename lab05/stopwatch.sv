module stopwatch(
    input logic clk,
    input logic rst, 
    input logic start_stop_btn,
    output logic [6:0] centesimos,
    output logic [5:0] segundos,
    output logic [6:0] minutos
);
    logic [6:0] cent_reg;
    logic [5:0] seg_reg;
    logic [6:0] min_reg;

    assign centesimos = cent_reg;
    assign segundos   = seg_reg;
    assign minutos    = min_reg;

    // Clock divisor para gerar pulso a cada 1 centésimo de segundo (0.01s)
    logic [18:0] counter;
    logic enable;


    // Divisor de clock para 1 centésimo (~500k ciclos)
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            enable <= 0;
        end else begin
            if (counter == 499_999) begin
                enable <= 1;
                counter <= 0;
            end else begin
                enable <= 0;
                counter <= counter + 1;
            end
        end
    end


    // Máquina de estados: controla se o cronômetro está parado ou rodando
    typedef enum logic {IDLE, RUNNING} state_t;
    state_t state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
        end else if (start_stop_btn) begin
            state <= (state == IDLE) ? RUNNING : IDLE;
        end
    end

    // Lógica do cronômetro
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            cent_reg <= 0;
            seg_reg  <= 0;
            min_reg  <= 0;
        end else if (enable && state == RUNNING) begin
            if (cent_reg == 99) begin
                cent_reg <= 0;
                if (seg_reg == 59) begin
                    seg_reg <= 0;
                    min_reg <= min_reg + 1;
                end else begin
                    seg_reg <= seg_reg + 1;
                end
            end else begin
                cent_reg <= cent_reg + 1;
            end
        end
    end

endmodule
