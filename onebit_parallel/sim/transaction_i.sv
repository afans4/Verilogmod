//  Class: transaction_i
`ifndef TRANSACTION_I
`define TRANSACTION_I
import "DPI-C" function void RadarDataGen(output real data[1024],input int range);

class transaction_i extends uvm_sequence_item;
    
    bit Re_data[];
    bit Im_data[];
    rand int range;
    
    //real data[];
    constraint range_cons {
        range > 0;
        range < 50;    
    }
    //`uvm_object_utils_begin(transaction_i)
    `uvm_object_utils_begin(transaction_i)
        `uvm_field_array_int(Re_data, UVM_ALL_ON)
        `uvm_field_array_int(IM_data, UVM_ALL_ON)
        `uvm_field_int(range, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name = "transaction_i");
        super.new(name);
    endfunction: new
    //生成回波数据，并一比特量化
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

    function void my_print();
        for(int i = 0; i < Re_data.size; i++) begin
        $display("my_transaction_i: Re_data[%0d] = %x , Im_data[%0d] = %x",
                    i, Re_data[i], i, Im_data[i]);		 
        
        end
       endfunction
endclass: transaction_i

`endif 
