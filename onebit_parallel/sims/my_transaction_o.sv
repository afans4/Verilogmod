`ifndef MY_TRANSACTION_O__SV
`define MY_TRANSACTION_O__SV
class my_transaction_o extends uvm_sequence_item;

	int   Re_data[];
	int   Im_data[];

   `uvm_object_utils_begin(my_transaction_o)
      `uvm_field_array_int(Re_data, UVM_ALL_ON) 
      `uvm_field_array_int(Im_data, UVM_ALL_ON)
   `uvm_object_utils_end
				
   function new(string name = "my_transaction_o");
      super.new(name);
   endfunction	
   
endclass

`endif