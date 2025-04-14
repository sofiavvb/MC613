module fsm_board (
    input logic [3:0] KEY,
    input logic [9:0] SW,      // switches
    input logic CLOCK_50,
    output logic [6:0] HEX2,    // valor inserido 1
    output logic [6:0] HEX1,    // valor inserido 2
    output logic [6:0] HEX0,    // valor inserido 3 
    output logic [9:0] LEDR    // leds
);

    logic [2:0] detector;
    logic fio;
    initial begin
        detector = 3'b0;
    end
    assign detector = ~detector[2] & detector[1];

    //inputs
    assign r50 = KEY[0];
    assign r100 = KEY[1]; 
    assign r200 = KEY[2];
    assign reset = SW[0];
    //outputs
    assign cafe = LEDR[0];
    assign t50 = LEDR[2];
    assign t100 = LEDR[3];
    assign t200 = LEDR[4];
    assign state = LEDR[9:6];

    //definindo os estados
    typedef enum logic [3:0] {
        S0   = 4'b0000,
        S50  = 4'b0001,
        S100 = 4'b0010,
        S150 = 4'b0011,
        S200 = 4'b0100,
        S250 = 4'b0101,
        S300 = 4'b0110,
        S350 = 4'b0111,
        S400 = 4'b1000
    } state_t;

    //definindo os estados como tipo estado
    state_t proximo_state, atual_state; 


    //transição de estado
    always_ff @(posedge CLOCK_50 or posedge reset) begin
        if (CLOCK_50)
            atual_state <= S0; //reset para o estado inicial
        else
            atual_state <= proximo_state; //avança para o próximo estado
    end


    //lógica de transição de estados
    always_comb begin
        proximo_state = atual_state; 
        cafe = 0;
        t50 = 0;
        t100 = 0;
        t200 = 0;

        case (atual_state)
            S0: begin
                if (r50)
                    proximo_state = S50;
                else if (r100)
                    proximo_state = S100;
                else if (r200)
                    proximo_state = S200;
            end
            S50: begin
                if (r50)
                    proximo_state = S100;
                else if (r100)
                    proximo_state = S150;
                else if (r200)
                    proximo_state = S250;
            end
            S100: begin
                if (r50)
                    proximo_state = S150;
                else if (r100)
                    proximo_state = S200;
                else if (r200)
                    proximo_state = S300;
            end
            S150: begin
                if (r50)
                    proximo_state = S200;
                else if (r100)
                    proximo_state = S250;
                else if (r200)
                    proximo_state = S350;
            end
            S200: begin
                if (r50)
                    proximo_state = S250;
                else if (r100)
                    proximo_state = S300;
                else if (r200)
                    proximo_state = S400;
            end
            S250: begin
                cafe = 1;
                proximo_state = S0;
            end
            S300: begin
                cafe = 1;
                t50 = 1;
                proximo_state = S0;
            end
            S350: begin
                cafe = 1;
                t100 = 1;
                proximo_state = S0;
            end
            S400: begin
                cafe = 1;
                t50 = 1;
                t100 = 1;
                proximo_state = S0;
            end
        endcase
    end

    assign state = atual_state; //estado atual de saída

endmodule