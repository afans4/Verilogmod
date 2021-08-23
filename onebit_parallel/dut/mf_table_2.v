module mf_table_2
	(
		input [3:0] table_in, // en-bit and data-bit
		output [16:0] table_out
	);
	reg	signed [16:0] out;
	parameter  DATA = 100;
	always @(*)
		begin
			casez(table_in)
			4'b0?0?: 		 out = 0;
			4'b0?10,4'b100?: out = DATA;
			4'b0?11,4'b110?: out = -DATA;
			4'b1010		   : out = 2*DATA;
			4'b1111		   : out = -2*DATA;
			default 	   : out = 0;
			endcase
		end
	assign table_out = out;
endmodule