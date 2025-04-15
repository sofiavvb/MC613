module fsm_board (
    input logic [3:0] KEY,
    input logic [9:0] SW,      // switches
    // input logic CLOCK_50,
    output logic [6:0] HEX2,    // valor inserido 1
    output logic [6:0] HEX1,    // valor inserido 2
    output logic [6:0] HEX0,    // valor inserido 3 
    output logic [9:0] LEDR    // leds
);
    //sinais de controle
    logic r50, r100, r200, reset;
    logic cafe, t50, t100, t200;
    logic [3:0] state;
    
    // detector de borda
    //logic [2:0] det_key0, det_key1, det_key2;
    //logic pulso_key0, pulso_key1, pulso_key2;
    

    //assign pulso_key0 = ~det_key0[2] & det_key0[1];
    //assign pulso_key1 = ~det_key1[2] & det_key1[1];
    //assign pulso_key2 = ~det_key2[2] & det_key2[1];

/*
	always_ff @(posedge ~KEY[0]) begin
        if (reset) begin
            det_key0 <= 3'b000;
            det_key1 <= 3'b000;
            det_key2 <= 3'b000;
        end else begin
            det_key0 <= {det_key0[1:0], ~KEY[0]};
            det_key1 <= {det_key1[1:0], ~KEY[1]};
            det_key2 <= {det_key2[1:0], ~KEY[3]};
        end
    end
*/

    //inputs
    assign r50  = ~KEY[3];
    assign r100 = ~KEY[2];
    assign r200 = ~KEY[1];
    assign reset = SW[0];

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
    always_ff @(posedge ~KEY[0] or posedge reset) begin
        if (reset)
            atual_state <= S0; //reset para o estado inicial
        else
            atual_state <= proximo_state; //avança para o próximo estado
    end


    //transição de estado
    //always_ff @(posedge CLOCK_50 or posedge reset) begin
    //    if (CLOCK_50)
    //        atual_state <= S0; //reset para o estado inicial
    //    else
    //        atual_state <= proximo_state; //avança para o próximo estado
    //end


    //lógica de transição de estados
    always_comb begin
        proximo_state = atual_state; 
        cafe = 0;
        t50 = 0;
        t100 = 0;
        t200 = 0;

        case (atual_state)
            S0: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b0111111; // 0
                HEX2 = ~7'b0111111; // 0
                if (r50)
                    proximo_state = S50;
                else if (r100)
                    proximo_state = S100;
                else if (r200)
                    proximo_state = S200;
            end
            S50: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b1101101; // 5
                HEX2 = ~7'b0111111; // 0
                if (r50)
                    proximo_state = S100;
                else if (r100)
                    proximo_state = S150;
                else if (r200)
                    proximo_state = S250;
            end
            S100: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b0111111; // 0
                HEX2 = ~7'b0000110; // 1
                if (r50)
                    proximo_state = S150;
                else if (r100)
                    proximo_state = S200;
                else if (r200)
                    proximo_state = S300;
            end
            S150: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b1101101; // 5
                HEX2 = ~7'b0000110; // 1
                if (r50)
                    proximo_state = S200;
                else if (r100)
                    proximo_state = S250;
                else if (r200)
                    proximo_state = S350;
            end
            S200: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b0111111; // 0
                HEX2 = ~7'b1011011; // 2
                if (r50)
                    proximo_state = S250;
                else if (r100)
                    proximo_state = S300;
                else if (r200)
                    proximo_state = S400;
            end
            S250: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b1101101; // 5
                HEX2 = ~7'b1011011; // 2
                cafe = 1;
                proximo_state = S0;
            end
            S300: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b0111111; // 0
                HEX2 = ~7'b1001111; // 3
                cafe = 1;
                t50 = 1;
                proximo_state = S0;
            end
            S350: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b1101101; // 5
                HEX2 = ~7'b1001111; // 3
                cafe = 1;
                t100 = 1;
                proximo_state = S0;
            end
            S400: begin
                HEX0 = ~7'b0111111; // 0
                HEX1 = ~7'b0111111; // 0
                HEX2 = ~7'b1100110; // 4
                cafe = 1;
                t50 = 1;
                t100 = 1;
                proximo_state = S0;
            end
        endcase
    end

    assign state = atual_state; //estado atual de saída

    //outputs
    assign LEDR[0] = cafe;
    assign LEDR[2] = t50;
    assign LEDR[3] = t100;
    assign LEDR[4] = t200;
    assign LEDR[9:6] = state;


endmodule