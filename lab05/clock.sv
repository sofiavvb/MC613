// clock para board -> unit watch e stopwatch

module clock (
    input logic CLOCK_100,
    input logic[3:0] KEY,
    input logic [5:0] SW,
    output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);
    logic mode = 0; // 0 = stopwatch, 1 = watch
    logic [1:0] mode_detector = 0; // para o debounce do key3
    logic [1:0] mode_edit = 0; // para def modo dentro de clock
    logic [4:0] unidade_0, dezena_0, unidade_1, dezena_1, unidade_2, dezena_2, w_horas;
    logic [5:0] s_segundos, w_segundos, w_minutos;
    logic [6:0] s_minutos, s_centesimos;
    logic [3:0] unidade, dezena;
    logic rst, start_stop_btn, blink;
    logic [5:0] set_numero;

    // debounce para KEY[2]
    logic [2:0] shift_key2;
    logic key2_debounced;

    // debounce do botão KEY[2] (modo do relógio)
    always_ff @(posedge CLOCK_100) begin
        shift_key2 <= {shift_key2[1:0], ~KEY[2]}; // botão ativo baixo
    end

    assign key2_debounced = (shift_key2[2:1] == 2'b01); // detecta borda de subida

    assign set_numero = SW; 

    // debounce do botão KEY[3]
    always_ff @(posedge CLOCK_100) begin
        mode_detector <= {mode_detector[0], ~KEY[3]};
        if (~mode_detector[1] & mode_detector[0])
            mode <= ~mode;
    end


    // instancia stopwatch
    stopwatch stopwatch_inst (
        .clk(CLOCK_100),
        .rst(~KEY[1]),
        .start_stop_btn(key2_debounced),
        .centesimos(s_centesimos),
        .segundos(s_segundos),
        .minutos(s_minutos)
    );

    // instancia watch
    watch watch_inst (
        .clk(CLOCK_100),
        .val(SW), 
        .mode_btn(key2_debounced),
        .segundos(w_segundos),
        .minutos(w_minutos),
        .horas(w_horas),
        .mode_edit(mode_edit),
        .blink(blink)
    );

    // conversao para decimal (divisão por 10)
    always_comb begin
        if (mode == 0) begin
            // stopwatch
            dezena_0  = s_centesimos / 10;
            unidade_0 = s_centesimos % 10;
            dezena_1  = s_segundos / 10;
            unidade_1 = s_segundos % 10;
            dezena_2  = s_minutos / 10;
            unidade_2 = s_minutos % 10;
        end else begin
            // watch
            dezena_0  = (mode_edit == 2'b11 && blink) ? 4'd10 : w_segundos / 10;
            unidade_0 = (mode_edit == 2'b11 && blink) ? 4'd10 : w_segundos % 10;
            dezena_1  = (mode_edit == 2'b10 && blink) ? 4'd10 : w_minutos / 10;
            unidade_1 = (mode_edit == 2'b10 && blink) ? 4'd10 : w_minutos % 10;
            dezena_2  = (mode_edit == 2'b01 && blink) ? 4'd10 : w_horas / 10;
            unidade_2 = (mode_edit == 2'b01 && blink) ? 4'd10 : w_horas % 10;
        end
    end


    //instanciando os displays
    dec_7seg dis_0 (
        .bin(unidade_0),
        .segs(HEX0)
    );
    dec_7seg dis_1 (
        .bin(dezena_0),
        .segs(HEX1)
    );
    dec_7seg dis_2 (
        .bin(unidade_1),
        .segs(HEX2)
    );
    dec_7seg dis_3 (
        .bin(dezena_1),
        .segs(HEX3)
    );
    dec_7seg dis_4 (
        .bin(unidade_2),
        .segs(HEX4)            
    );
    dec_7seg dis_5 (
        .bin(dezena_2),
        .segs(HEX5)
    );

endmodule