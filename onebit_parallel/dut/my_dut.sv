
 module my_dut(
 		input	clk,
		input	rst_n,
		input	en,
		input	x_re,
		input	x_im,
		output reg	signed [31:0]	y_IM,
		output reg  signed [31:0]	y_RE,
		output reg	valid 
		); 


wire signed [31:0]	y_MFim_Xim, y_MFre_Xre, y_MFre_Xim, y_MFim_Xre;
wire				en_MFim_Xim, en_MFre_Xre, en_MFre_Xim, en_MFim_Xre;

//reg	signed [31:0]	y_RE, y_IM;
//reg					valid;

mf_1bit_512order_Re  MFre_Xre(
				.clk(clk),
				.rst_n(rst_n),
				.x_in(x_re),
				.en(en),
				.y_out(y_MFre_Xre),
				.en_o(en_MFre_Xre)); 	
mf_1bit_512order_Im  MFim_Xim(
				.clk(clk),
				.rst_n(rst_n),
				.x_in(x_im),
				.en(en),
				.y_out(y_MFim_Xim),
				.en_o(en_MFim_Xim)); 

mf_1bit_512order_Im  MFim_Xre(
				.clk(clk),
				.rst_n(rst_n),
				.x_in(x_re),
				.en(en),
				.y_out(y_MFim_Xre),
				.en_o(en_MFim_Xre)); 
mf_1bit_512order_Re  MFre_Xim(
				.clk(clk),
				.rst_n(rst_n),
				.x_in(x_im),
				.en(en),
				.y_out(y_MFre_Xim),
				.en_o(en_MFre_Xim)); 					
	
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n)begin
			y_RE <= 32'b0;
			y_IM <= 32'b0;
			valid <= 1'b0;
		end
		else if(en_MFre_Xim & en_MFim_Xim & en_MFim_Xre & en_MFre_Xre)begin
			y_RE <= y_MFre_Xre - y_MFim_Xim;
			y_IM <= y_MFim_Xre + y_MFre_Xim;
			valid <= 1'b1;
		end			
		else begin
			y_RE <= 32'b0;
			y_IM <= 32'b0;
			valid <= 1'b0;
		end
	end
		
endmodule