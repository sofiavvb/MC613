
module uart (
	clk_clk,
	rst_reset_n,
	av_chipselect,
	av_address,
	av_read_n,
	av_readdata,
	av_write_n,
	av_writedata,
	av_waitrequest);	

	input		clk_clk;
	input		rst_reset_n;
	input		av_chipselect;
	input		av_address;
	input		av_read_n;
	output	[31:0]	av_readdata;
	input		av_write_n;
	input	[31:0]	av_writedata;
	output		av_waitrequest;
endmodule
