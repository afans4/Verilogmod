`ifndef CASE0
`define CASE0

class case0_sequence extends uvm_sequence #(transaction_i);
    `uvm_object_utils(case0_sequence)

    transaction_i tr_i;

    function new(string name = "case0_sequence");
        super.new(name);
    endfunction: new

    extern virtual task body();
endclass

task case0_sequence::body();
    `uvm_info(get_name(), "sequence begin", UVM_NONE)
    if (starting_phase != null) begin
        starting_phase.raise_objection(this);
    end
    repeat (2) begin
        `uvm_info(get_name(), "seq send", UVM_NONE)
        `uvm_do(tr_i)
    end 
    #100;
    if(starting_phase != null) begin
        starting_phase.drop_objection(this);
    end
endtask: body

class my_case0 extends base_test;
    function new(string name = "my_case0", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    //  Function: build_phase
    extern virtual function void build_phase(uvm_phase phase);
    `uvm_component_utils(my_case0)
endclass //my_case0 extends base_test

function void my_case0::build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvm_config_db#(uvm_object_wrapper)::set(this, 
                                           "env.i_agt.sqr.main_phase", 
                                           "default_sequence", 
                                           case0_sequence::type_id::get());
    `uvm_info(get_name(), "my_case0 begin", UVM_NONE)
    
    
endfunction: build_phase


`endif