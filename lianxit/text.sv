`timescale 1ps/1ps
//  Module: text

class myclass;
    rand bit [7:0] data[$];
    string name;
    
    constraint c {
        /*  solve order constraints  */
        data.size() inside {[20:30]};
        /*  rand variable constraints  */
        
    }
    
    function new(string name);
        this.name = name;
    endfunction

    function void print();
        foreach (data[i]) begin
            $display("data[%0d] = %0d",i,data);
        end
    endfunction
endclass

module text;
    
    initial begin
        myclass tr;
        bit [7:0] a[$];
        bit [7:0] b[$];
        bit [7:0] min,secmin;
        tr = new("tr1");
        randtr: assert (tr.randomize())
            else $error("Assertion label failed!");
        tr.print();
        #10
        a = tr.data;
        min = a.min();
        b = a.delect()

        $stop();
    end
    
endmodule: text
