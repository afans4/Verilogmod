

module	mf_1bit_512order_Re
		#(  parameter	W1 = 1,  //bit widrh
			parameter	W2 = 17, // data(16)*2 = data(17)
			parameter	W3 = 32, //Adder width = W2+log2(L)-1   32--> for east to test
			parameter	L = 512, //
			parameter	L2 = 256,
			parameter	Dy = 8
		)( 	input		clk,
			input		rst_n,
			input	[W1-1:0]	x_in,
			input 				en,
			output	signed	[W3-1:0]	y_out,
			output				en_o
			);
// --------------------------------------------------------
parameter  integer  Filpara [0:255] = {
			-16974, -28695, -32763, -28191,  -16272,   -178,  15903,  27868,
			 32733,  29357,  18678,   3420,  -12620, -25529, -32227, -31184,
			-22739,  -8970,   6842,	 21008,	  30291,  32634,  27591,  16385,
			  1581, -13513,	-25593,	-32080,	 -31648, -24478, -12168,   2638,
			16836,	27512,	32534,	30960,	23191,	10850,	-3573,	-17238,
			-27513,	-32475,	-31254,	-24162,	-12600,	1236,	14786,	25596,
			31765,	32259,	27071,	17186,	4377,	-9122,	-21013,	-29323,
			-32722,	-30721,	-23726,	-12937,	-134,	12628,	23353,	30407,
			32765,	30138,	22997,	12473,	166,	-12102,	-22565,	-29758,
			-32718,	-31098,	-25194,	-15881,	-4472,	7474,	18368,	26805,
			31733,	32580,	29306,	22391,	12748,	1603,	-9673,	-19732,
			-27408,	-31847,	-32594,	-29628,	-23349,	-14514,	-4137,	6626,
			16615,	24787,	30321,	32694,	31722,	27566,	20699,	11845,
			1902,	-8161,	-17389,	-24941,	-30154,	-32602,	-32120,	-28809,
			-23016,	-15287,	-6317,	3119,	12233,	20292,	26673,	30906,
			32709,	31995,	28872,	23627,	16689,	8598,	-43,	-8617,
			-16532,	-23265,	-28393,	-31614,	-32765,	-31820,	-28888,	-24198,
			-18079,	-10931,	-3200,	4651,	12173,	18953,	24637,	28945,
			31684,	32752,	32139,	29919,	26246,	21337,	15461,	8919,
			2030,	-4885,	-11519,	-17592,	-22863,	-27134,	-30260,	-32150,
			-32767,	-32125,	-30289,	-27361,	-23484,	-18824,	-13568,	-7914,
			-2062,	3790,	9458,	14770,	19579,	23758,	27209,	29861,
			31668,	32612,	32701,	31965,	30452,	28229,	25378,	21988,
			18159,	13992,	9591,	5057,	488,	-4024,	-8395,	-12549,
			-16421,	-19954,	-23103,	-25835,	-28125,	-29957,	-31327,	-32238,
			-32699,	-32728,	-32346,	-31581,	-30463,	-29026,	-27305,	-25335,
			-23153,	-20795,	-18297,	-15693,	-13014,	-10292,	-7553,	-4824,
			-2126,	519,	3093,	5583,	7975,	10259,	12427,	14473,
			16393,	18185,	19848,	21384,	22793,	24080,	25249,	26303,
			27248,	28091,	28837,	29493,	30065,	30561,	30986,	31347,
			31651,	31904,	32111,	32279,	32413,	32517,	32596,	32655,
			32697,	32726,	32745,	32756,	32763,	32766,	32767,	32767 };
// --------------------------------------------------------
	reg		[W1:0]               x_reg [0:L-1];       //en + 1-bit data
	wire 	[2*(W1+1)-1:0]		 table_in [0:L2-1];  // orders/2
	wire signed [W2-1:0]		 table_out [0:L2-1];

	reg	signed [W3-1:0] adder [0:L2-2];
	reg 	[Dy-1:0] en_delay;

// input 1-bit data reg
	always@(posedge clk or negedge rst_n)begin: ctr_x_reg
		integer k;
		if(!rst_n)begin
			for(k=0;k<L; k=k+1)	x_reg[k] <= 2'b00;
		end
		else begin
			x_reg[0] <= {en,x_in};
			for(k=0;k<L-1; k=k+1)	x_reg[k+1] <= x_reg[k];
			end
	end

// 	adder tree
	always@(posedge clk or negedge rst_n)begin: ctr_Adder
		integer i,j,k,l,m,n;
		if(!rst_n)begin
			for(i=0;i<L2-1; i=i+1)  adder[i] <= 0;
		end
		else begin  // the tree is 8-order, the output delay 8 clk
		    for(j = 0;j < 256 ; j = j + 2)begin
			   adder[j/2] <= table_out[j] + table_out[j+1]; //128 adder
			end
			for(k = 0; k < 128 ; k = k + 2)begin            //64 adder
				adder[k/2+128] <= adder[k] + adder[k+1];
			end
			for(l = 0; l< 64 ; l = l + 2)begin
				adder[l/2+192] <= adder[128+l] + adder[129+l]; //32 adder
			end
			for(m = 0; m< 32 ; m = m + 2)begin
				adder[m/2+224] <= adder[192+m] + adder[193+m]; //16 adder
			end
			for(n = 0; n< 16 ; n = n + 2)begin
				adder[n/2+240] <= adder[224+n] + adder[225+n]; //8 adder
			end
			adder[248] <= adder[240] + adder[241];
			adder[249] <= adder[242] + adder[243];
			adder[250] <= adder[244] + adder[245];
			adder[251] <= adder[246] + adder[247];

			adder[252] <= adder[248] + adder[249];
			adder[253] <= adder[250] + adder[251];

			adder[254] <= adder[252] + adder[253];
		end

	end
		assign y_out = adder[254];


		always@(posedge clk or negedge rst_n) begin :en_o_delay
			if(!rst_n) begin
				en_delay <= 0;
				end
			else  begin
				en_delay <= {en_delay[Dy-2:0],(x_reg[0][1] | x_reg[L-1][1])};
			end
		end
		assign en_o = en_delay[Dy-1];

// 	table input reg
		generate
		genvar i ;
		for (i = 0; i < L2 ; i=i+1) begin : ctr_table_input_reg
			assign table_in[i] = {x_reg[i],x_reg[L-i-1]};
		end
		endgenerate
// 	table generate
		generate
		genvar k ;
		for (k = 0; k < L2 ; k=k+1) begin : TABLE
			 mf_table_2 #(.DATA(Filpara[k])) Table(.table_in(table_in[k]),
			 	.table_out(table_out[k]));
		end
		endgenerate



endmodule