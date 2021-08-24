`ifndef MY_TRANSACTION_I__SV
`define MY_TRANSACTION_I__SV

import "DPI-C" function void RadarDataGen(output real data[1024],input int range);

class my_transaction_i extends uvm_sequence_item;

	bit Re_data[];
	bit Im_data[];
    rand int range;
	//real data[];
 	constraint range_cons{
				range > 0;
				range < 50;
				} 
	//`uvm_object_utils(my_transaction_i)
	`uvm_object_utils_begin(my_transaction_i)
		`uvm_field_array_int(Re_data, UVM_ALL_ON) 
		`uvm_field_array_int(Im_data, UVM_ALL_ON)
		`uvm_field_int(range, UVM_ALL_ON)
	`uvm_object_utils_end
			
				
   	function new(string name = "my_transaction_i");
      	super.new(name);
   	endfunction		
     	
   	function void post_randomize();
		real data[];
		data = new[1024];
		RadarDataGen(data,range);
		Re_data = new[512];
		Im_data = new[512];
		for (int i=0; i<512; ++i) begin
			Re_data[i] = (data[i]>=0) ? 1'b0 : 1'b1;
		end
		for (int i=512; i<1024; ++i) begin
			Im_data[i-512] = (data[i]>=0) ? 1'b0 : 1'b1;
		end
	endfunction 
	
endclass

`endif