`ifndef TRANSACTION_O
`define TRANSACTION_O

//  Class: transaction_o
//
class transaction_o extends uvm_sequence_item;
    int Re_data[];
    int Im_data[];
    //`uvm_object_utils(transaction_o);
    `uvm_object_utils_begin(transaction_o)
        `uvm_field_array_int(Re_data, UVM_ALL_ON) 
        `uvm_field_array_int(Im_data, UVM_ALL_ON)
    `uvm_object_utils_end
    
    function new(string name = "transaction_o");
        super.new(name);
    endfunction: new

    function void my_print();
        for(int i = 0; i < Re_data.size; i++) begin
           $display("my_transaction_o: Re_data[%0d] = %d , Im_data[%0d] = %d",
                 i, Re_data[i], i, Im_data[i]);		    
         end
    endfunction

    function bit my_compare(transaction_o tr);
        bit result;
        
        if(tr == null)
           `uvm_fatal("my_transaction", "tr is null!!!!")
   
        if( (Re_data.size() != tr.Re_data.size()) | (Im_data.size() != tr.Im_data.size()) )
           result = 0;
        else begin
             result = 1;
           for(int i = 0; i < Re_data.size(); i++) begin
              if((Re_data[i] != tr.Re_data[i]) | (Im_data[i] != tr.Im_data[i]) ) begin
                 result = 0;
                 break;
              end
           end
          end
        return result; 
    endfunction
endclass: transaction_o
`endif 

