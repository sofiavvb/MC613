module multiplier #(
    parameter int N = 4 // tamanho do multiplicador
)(
    input logic clk,
    input logic set,
    input logic [N-1:0] a, // multiplicando
    input logic [N-1:0] b, // multiplicador
    output logic [2*N-1:0] r // resultado
); 

    typedef enum logic[2:0]{
        IDLE, LOAD, CHECK, ADD, SHIFT, DONE
    } state_t;

    state_t state;

    logic [N-1:0] M, Q;
    logic [N:0] A; //acumulador
    logic [$clog2(N+1)-1:0] count; //menor numero de bits para os N valores

    always_ff @(posedge clk) begin //tudo acontece a cada pulso do clock
        case(state) //cada estado possivel
            IDLE: begin //set = 1, inicio de uma nova multiplicacao
                if (set)
                    state <= LOAD;
            end
            LOAD: begin //carrega os inputs
                A <= 0;
                M <= a;
                Q <= b;
                count <= N;
                state <= CHECK;
            end

            CHECK: begin
                if(Q[0]==1)
                    state <= ADD;
                else
                    state <= SHIFT;
            end

            ADD: begin
                A <= A + M;
                state <= SHIFT;
            end

            SHIFT: begin
                {A, Q} <= {1'b0, A, Q} >> 1; // shifta
                count <= count - 1; //indica o numero necessario de ciclos
                if (count == 0)
                    state <= DONE;
                else
                    state <= CHECK;
            end

            DONE: begin
                r <= {A[N-1:0], Q}; //coombina A e Q para dar o produto
                state <= IDLE; //reinicia
            end
        endcase
    end
endmodule

