//  Class: transaction_i
`ifndef TRANSACTION_I
`define TRANSACTION_I
import "DPI-C" function void RadarDataGen(output real data[1024],input int range);
class transaction_i;
    string name;
    bit Re_data[];
    bit Im_data[];
    rand bit [7:0] data[];
    //real data[];
    //real data[];
    constraint range_cons {
        data.size() == 10;
        data.sum() == 100;  
          
    }
    
    function void my_print();
        for(int i = 0; i < data.size; i++) begin
        $display("my_transaction_i: data[%0d] = %d ,",
                    i, data[i]);		 
        
        end
    endfunction

    function new(string name = "transaction_i");
        this.name = name;
    endfunction: new
    //生成回波数据，并一比特量化
    //function void post_randomize();
    //    data = new[1024];
    //    RadarDataGen(data,range);
    //    Re_data = new[512];
    //    Im_data = new[512];
    //    for (int i=0; i<512; ++i) begin
    //        Re_data[i] = (data[i]>=0) ? 1'b0 : 1'b1;
    //    end
    //    for (int i=512; i<1024; ++i) begin
    //        Im_data[i-512] = (data[i]>=0) ? 1'b0 : 1'b1;
    //    end
    //endfunction    
endclass: transaction_i

`endif 
