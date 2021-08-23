`ifndef ENV_SV
`define ENV_SV

class my_env extends uvm_env;
    agent       i_agt;
    agent       o_agt;
    remodel     mdl;
    scoreboard  scb;
    
    uvm_tlm_analysis_fifo #(transaction_o) agt_scb_fifo;
    uvm_tlm_analysis_fifo #(transaction_i) agt_mdl_fifo;
    uvm_tlm_analysis_fifo #(transaction_o) mdl_scb_fifo;

    `uvm_component_utils(my_env);

    function new(string name = "my_env", uvm_component parent);
        super.new(name, parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    
endclass

function void my_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    i_agt = agent::type_id::create("i_agt", this);
    o_agt = agent::type_id::create("o_agt", this);
    i_agt.is_active = UVM_ACTIVE;
    o_agt.is_active = UVM_PASSIVE;

    mdl = remodel::type_id::create("mdl", this);
    scb = scoreboard::type_id::create("scb", this);
    agt_scb_fifo = new("agt_scb_fifo", this);
    agt_mdl_fifo = new("agt_mdl_fifo", this);
    mdl_scb_fifo = new("mdl_scb_fifo", this);
    `uvm_info(get_name(), "env builded", UVM_NONE)
    
endfunction: build_phase

function void my_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //input agent connect remodel
    i_agt.api.connect(agt_mdl_fifo.analysis_export);
    mdl.port.connect(agt_mdl_fifo.blocking_get_export);
    //output agent connect scoreboard
    o_agt.apo.connect(agt_scb_fifo.analysis_export);
    scb.act_port.connect(agt_scb_fifo.blocking_get_export);
    //remodel connect scoreboard
    mdl.ap.connect(mdl_scb_fifo.analysis_export);
    scb.exp_port.connect(mdl_scb_fifo.blocking_get_export);
endfunction: connect_phase

`endif