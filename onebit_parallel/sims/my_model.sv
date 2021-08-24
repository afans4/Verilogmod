`ifndef MY_MODEL__SV
`define MY_MODEL__SV

class my_model extends uvm_component;
   
   uvm_blocking_get_port #(my_transaction_i)  port;
   uvm_analysis_port #(my_transaction_o)  ap;
   
	int  Re_filter[512];
	int  Im_filter[512];	
	int  size_R;
	int  size_I;
	int  Re_filter_b[0:255]  = '{
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
		
	int  Im_filter_b[0:255]  = '{
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
// --------------------------------------------------------  //

   extern function new(string name, uvm_component parent);
   extern function void build_phase(uvm_phase phase);
   extern virtual  task main_phase(uvm_phase phase);
   extern function void my_conv(ref int y_data[],ref bit x_data[],ref int filer[512],input int xdata_size);
   extern function int my_xnor(bit x_in , int sref);
   `uvm_component_utils(my_model)
endclass 
	function my_model::new(string name, uvm_component parent);
	   super.new(name, parent);
	endfunction 

	function void my_model::build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   port = new("port", this);
	   ap = new("ap", this);
	endfunction

	task my_model::main_phase(uvm_phase phase);
		bit  Re_x[];
		bit  Im_x[];
		
		int data_MFre_Xre[];
		int data_MFim_Xim[];
		int data_MFre_Xim[];
		int data_MFim_Xre[];
		int Re_out[];
		int Im_out[];
		
		my_transaction_i tr;
		my_transaction_o tr_o;
		
		for(int i = 0 ; i < 256 ; i++)begin    //flier parameter to Flier
			Re_filter[i]       = Re_filter_b[i];
			Re_filter[511 - i] = Re_filter_b[i];
			Im_filter[i]       = Im_filter_b[i];
			Im_filter[511 - i] = Im_filter_b[i];
		end
					
		//super.main_phase(phase);
		while(1) begin
			port.get(tr);
			size_R = tr.Re_data.size; 	
			size_I = tr.Im_data.size; 		
			Re_x = new[size_R];
			Im_x = new[size_I];
			Re_x = tr.Re_data;
			Im_x = tr.Im_data;
			
			data_MFre_Xre = new [size_R + 512 - 1];
			data_MFim_Xim = new [size_I + 512 - 1];
			data_MFim_Xre = new [size_R + 512 - 1];
			data_MFre_Xim = new [size_I + 512 - 1];
			Re_out = new [size_R + 512 - 1];
			Im_out = new [size_I + 512 - 1];
			
			my_conv(data_MFre_Xre,Re_x,Re_filter,size_R);
			my_conv(data_MFim_Xim,Im_x,Im_filter,size_I);
			my_conv(data_MFre_Xim,Im_x,Re_filter,size_I);
			my_conv(data_MFim_Xre,Re_x,Im_filter,size_R);
			
			
			for(int i = 0 ; i < data_MFre_Xre.size ; i++)begin
				Re_out[i]  = data_MFre_Xre[i] - data_MFim_Xim[i];
				Im_out[i]  = data_MFim_Xre[i] + data_MFre_Xim[i];
			end
			
			tr_o = new("tr_o");
			tr_o.Re_data = new[Re_out.size];
			tr_o.Im_data = new[Im_out.size];			
			tr_o.Re_data = Re_out;
			tr_o.Im_data = Im_out;

		//	tr_o.my_print();
			ap.write(tr_o);
			`uvm_info("my_model", "model computer ending", UVM_LOW);
			
		end
		
	endtask
	
	function void my_model::my_conv(ref int y_data[],ref bit x_data[],ref int filer[512],input int xdata_size);
	    int m,n,cnt;
			for(m = 0 ; m < xdata_size ; m++) begin
			  for(n = 0 ; n < 512 ; n++) begin
				cnt = m + n ;
				y_data[cnt] = my_xnor(x_data[m],filer[n]) + y_data[cnt];
			  end
			end
	endfunction
	
	function int my_model::my_xnor(bit x_in , int sref);
		if ((x_in == 0 && sref > 0))
			my_xnor = sref;
		else if ( (x_in == 1 && sref < 0) )
			my_xnor = -sref;
		else if ((x_in == 0 && sref < 0) )
			my_xnor = sref;
		else if( (x_in == 1 && sref > 0) )
			my_xnor = -sref;
		else
			my_xnor = 0;
	endfunction
`endif