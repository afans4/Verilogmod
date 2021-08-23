`ifndef SEQUENCER_SV
`define SEQUENCER_SV

class sequencer extends uvm_sequencer #(transaction_i);
    
    
    `uvm_component_utils(sequencer);

    function new(string name = "sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction
    
endclass

`endif