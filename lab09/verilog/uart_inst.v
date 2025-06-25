	uart u0 (
		.clk_clk        (<connected-to-clk_clk>),        // clk.clk
		.rst_reset_n    (<connected-to-rst_reset_n>),    // rst.reset_n
		.av_chipselect  (<connected-to-av_chipselect>),  //  av.chipselect
		.av_address     (<connected-to-av_address>),     //    .address
		.av_read_n      (<connected-to-av_read_n>),      //    .read_n
		.av_readdata    (<connected-to-av_readdata>),    //    .readdata
		.av_write_n     (<connected-to-av_write_n>),     //    .write_n
		.av_writedata   (<connected-to-av_writedata>),   //    .writedata
		.av_waitrequest (<connected-to-av_waitrequest>)  //    .waitrequest
	);

