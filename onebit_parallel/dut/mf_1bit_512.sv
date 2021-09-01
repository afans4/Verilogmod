//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : mf_1bit_512
//Create  : 2021-08-26
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module	mf_1bit_512
    #(  parameter	W1 = 1,  //bit widrh
        parameter	W2 = 17, // data(16)*2 = data(17)
        parameter	W3 = 32, //Adder width = W2+log2(L)-1   32--> for east to test
        parameter	L = 512, //
        parameter	L2 = 256,
        parameter	Dy = 8,
        parameter  integer  Filpara [0:255]
    )( 	input		                clk,
        input		                rst_n,
        input	        [W1-1:0]	x_in,
        input 				        en,
        output	signed	[W3-1:0]	y_out,
        output				        en_o
        );

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