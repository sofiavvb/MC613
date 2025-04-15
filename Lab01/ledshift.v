module ledshift (
    output wire [9:0] LEDR,  
    input [3:0] KEY,                        
    input CLOCK_50                         
);

    reg [9:0] registrador;  // Registrador para armazenar o estado dos LEDs
	 reg [2:0] detector_dir, detector_esq;
	 wire fiozinho, fiozao;
	 
	initial begin
		registrador = 10'b0000100000;
		detector_esq = 3'b000;
		detector_dir = 3'b000;
	end
	 
	 assign fiozinho = ~detector_dir[2] & detector_dir[1];
	 assign fiozao = ~detector_esq[2] & detector_esq[1];


	always @(posedge CLOCK_50) begin
			detector_dir <= {detector_dir[1:0], ~KEY[0]};
			detector_esq <= {detector_esq[1:0], ~KEY[3]};
	end
	 
	 
    always @(posedge CLOCK_50) begin
        if (registrador[0] == 1'b0 && fiozinho) begin
            registrador <= registrador >> 1;
        end

        if (registrador[9] == 1'b0 && fiozao) begin
            registrador <= registrador << 1;
        end

 
    end

	 
	 assign LEDR = registrador;  
endmodule
