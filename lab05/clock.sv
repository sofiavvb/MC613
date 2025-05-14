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
    logic [7:0] numero_0, numero_1, numero_2, w_horas;
    logic [6:0] s_segundos, w_segundos, w_minutos;
    logic [6:0] s_minutos, s_centesimos;
    logic [3:0] unidade, dezena;
    logic rst, start_stop_btn, blink, key1;
    logic [5:0] set_numero;

    // debounce para KEY[2]
    logic [2:0] shift_key2;
    logic key2_debounced, key2_stopwatch, key2_watch;

    // debounce do botao KEY[2] 
    always_ff @(posedge CLOCK_100) begin
        shift_key2 <= {shift_key2[1:0], ~KEY[2]}; // botão ativo baixo
    end

    assign key2_debounced = (shift_key2[2:1] == 2'b01); // detecta borda de subida

    assign set_numero = SW; 

    // logica para key2 so funcionar dentro do modo
    always_comb begin
        key2_stopwatch = (mode == 0 && key2_debounced) ? 1 : 0;
        key2_watch = (mode == 1 && key2_debounced) ? 1 : 0;
    end

    // logica para travar key1 quando no watch
    always_comb begin
        key1 = (mode == 0 && ~KEY[1]) ? 1 : 0;
    end

    // debounce do botao KEY[3]
    always_ff @(posedge CLOCK_100) begin
        mode_detector <= {mode_detector[0], ~KEY[3]};
        if (~mode_detector[1] & mode_detector[0])
            mode <= ~mode;
    end


    // instancia stopwatch
    stopwatch stopwatch_inst (
        .clk(CLOCK_100),
        .rst(key1),
        .start_stop_btn(key2_stopwatch),
        .centesimos(s_centesimos),
        .segundos(s_segundos),
        .minutos(s_minutos)
    );

    // instancia watch
    watch watch_inst (
        .clk(CLOCK_100),
        .val(SW), 
        .mode_btn(key2_watch),
        .segundos(w_segundos),
        .minutos(w_minutos),
        .horas(w_horas),
        .mode_edit(mode_edit),
        .blink(blink)
    );

    always_comb begin
        if (mode == 0) begin
            // stopwatch
            numero_0  = s_centesimos;
            numero_1  = s_segundos;
            numero_2  = s_minutos;
        end else begin
            // watch
            numero_0  = (mode_edit == 2'b11 && blink) ? 7'd101 : w_segundos;
            numero_1  = (mode_edit == 2'b10 && blink) ? 7'd101 : w_minutos;
            numero_2  = (mode_edit == 2'b01 && blink) ? 7'd101 : w_horas;
        end
    end


    //instanciando os displays
    dec_7seg dis_01 (
        .bin(numero_0),
        .segs_unidade(HEX0),
        .segs_dezena(HEX1)
    );

        dec_7seg dis_23 (
        .bin(numero_1),
        .segs_unidade(HEX2),
        .segs_dezena(HEX3)
    );

        dec_7seg dis_45 (
        .bin(numero_2),
        .segs_unidade(HEX4),
        .segs_dezena(HEX5)
    );


endmodule