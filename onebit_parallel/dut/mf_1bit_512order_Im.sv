/* ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝ *\
Filename 	 	 ：mf_1bit_512order_Im.v
Author 			 ﹕Afans
Description 	 ﹕512-orders Match filer	
Called by 		 ﹕Core module
Create			 ﹕2020-6-26
Organization 	 ﹕ MDSP-LAB
vision：
This vision uses 512-order (parameters num = 256)
\* ＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝ */

module	mf_1bit_512order_Im
	#(  parameter	W1 = 1,  //bit widrh  
		parameter	W2 = 17, // data(16)*2 = data(17)
		parameter	W3 = 32, //Adder width = W2+log2(L)-1   32--> for east to test
		parameter	L = 512, //
		parameter	L2 = 256,		
		parameter	Dy = 8
	)( 	input						clk,
		input						rst_n,
		input			[W1-1:0]	x_in,
		input 						en,
		output	signed	[W3-1:0]	y_out,
		output						en_o
		);
// -------------------------------------------------------- 
parameter  integer  Filpara [0:255] = {
		28028,15820,-541,-16702,-28441,-32767,-28649,-17236,
		-1500,14554,26922,32588,30239,20541,5922,-10060,
		-23592,-31515,-32045,-25147,-12496,2953,17675,28376,
		32729,29851,20461,6675,-8488,-21783,-30424,-32661,
		-28111,-17797,-3898,10731,23149,30919,32572,27866,
		17796,4362,-9842,-22133,-30248,-32744,-29241,-20458,
		-8042,5747,18461,27899,32473,31472,25142,14624,
		1725,-11397,-22600,-30105,-32767,-30236,-22985,-12209,
		386,12861,23342,30300,32767,30450,23759,13715,
		1789,-10325,-20951,-28661,-32460,-31903,-27134,-18846,
		-8167,3497,14656,23923,30185,32728,31307,26160,
		17958,7711,-3365,-13995,-22989,-29377,-32505,-32090,
		-28242,-21430,-12422,-2187,8209,17714,25402,30551,
		32712,31735,27772,21252,12822,3287,-6480,-15611,
		-23323,-28983,-32152,-32618,-30398,-25728,-19033,-10885,
		-1950,7071,15494,22704,28199,31619,32767,31614,
		28291,23074,16356,8614,375,-7823,-15465,-22094,
		-27328,-30890,-32610,-32435,-30422,-26729,-21603,-15358,
		-8354,-977,6385,13362,19617,24868,28890,31530,
		32704,32401,30676,27644,23473,18369,12570,6329,
		-96,-6452,-12501,-18029,-22851,-26820,-29826,-31797,
		-32702,-32547,-31372,-29249,-26275,-22566,-18257,-13491,
		-8416,-3180,2073,7207,12099,16637,20728,24294,
		27275,29629,31332,32374,32763,32519,31673,30269,
		28356,25991,23236,20155,16813,13276,9606,5865,
		2110,-1606,-5235,-8735,-12069,-15204,-18115,-20781,
		-23187,-25323,-27182,-28765,-30072,-31109,-31885,-32410,
		-32698,-32763,-32621,-32288,-31782,-31120,-30319,-29398,
		-28372,-27258,-26071,-24828,-23540,-22222,-20885,-19541,
		-18199,-16870,-15560,-14278,-13029,-11820,-10656,-9541,
		-8478,-7471,-6522,-5633,-4806,-4043,-3344,-2710,
		-2142,-1641,-1206,-837,-536,-301,-134,-33};
// -------------------------------------------------------- 	
	reg			[W1:0]         x_reg 	 [0:L-1];       //en + 1-bit data
	wire 		[2*(W1+1)-1:0] table_in  [0:L2-1];  // orders/2
	wire signed [W2-1:0]	   table_out [0:L2-1];
	
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
