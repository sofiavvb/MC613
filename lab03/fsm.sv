module fsm (
    input  logic clk,
    input  logic rst, 
    input  logic r50,
    input  logic r100,
    input  logic r200,
    output logic cafe,
    output logic t50,
    output logic t100,
    output logic t200,
    output logic [3:0] state // Estado atual (4 bits, suportando até 16 estados)
);

    // Definindo os estados
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

    state_t proximo_state, atual_state; 

    // Transição de estado síncrona
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            atual_state <= S0; // Reset para o estado inicial
        else
            atual_state <= proximo_state; // Avança para o próximo estado
    end

    // Lógica de transição de estados
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

    assign state = atual_state; // Estado atual de saída

endmodule

