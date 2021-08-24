`ifndef MY_IF__SV
`define MY_IF__SV

interface my_if(input clk, input rst_n);
	logic  		x_re;
	logic		x_im;
	logic		en;
	logic		[31:0] y_IM;
	logic		[31:0] y_RE;
	logic		valid;
	
/* 	modport		TEST( input clk, rst_n, y_IM, y_RE, valid,
					  output x_im, x_re, en); */
/* 	modport		DUT ( input clk, rst_n, en, x_re, x_im, 
					  output y_IM, y_RE, valid	); */
endinterface
`endif