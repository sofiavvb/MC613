module stopwatch(
    input logic clk,
    input logic rst, 
    input logic start_stop_btn,  
    output logic [6:0] centesimos;
    output logic [5:0] segundos;
    output logic [6:0] minutos;
);
    logic [18:0] counter;
    logic enable;
    // Contadores
   


    //dividir o clock para pegar 1 cent de segundo
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            enable <= 0;
            centesimos <= 0;
            segundos <= 0;
            minutos <= 0;
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

    //FSM DO CRONOMETRO
    typedef enum logic {IDLE, RUNNING} state_t;
    state_t state;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE; //parado
        end else if (start_stop_btn) begin
            state <= (state == IDLE) ? RUNNING : IDLE;
        end
    end

    always_ff @(posedge clk) begin 
        if(enable == 1 && state == RUNNING) begin
            if(centesimos == 99) begin
                centesimos <= 0;
                if (segundos == 59) begin
                    segundos <= 0;
                    minutos <= minutos + 1;
                end else begin
                    segundos <= segundos + 1;
                end 
            end else begin
                centesimos <= centesimos + 1; 
            end
        end
    end

endmodule
