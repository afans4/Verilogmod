`ifndef AGENT_SV
`define AGENT_SV

class agent extends uvm_agent;
    driver      drv;
    sequencer   sqr;
    monitor   mon_i;
    monitor   mon_o;
   
    uvm_analysis_port #(transaction_i)  api;
    uvm_analysis_port #(transaction_o)  apo;
    `uvm_component_utils(agent);

    function new(string name = "agent", uvm_component parent);
        super.new(name, parent);
    endfunction

    //  Function: build_phase
    extern virtual function void build_phase(uvm_phase phase);
    //  Function: connect_phase
    extern virtual function void connect_phase(uvm_phase phase);
      
endclass

function void agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (is_active == UVM_ACTIVE) begin
        sqr = sequencer::type_id::create("sqr",this);
        drv = driver::type_id::create("drv",this);
        mon_i = monitor::type_id::create("mon_i",this);
        mon_i.iosel = 1'b0;
        `uvm_info(get_name(), "input agent builded", UVM_NONE)
        
    end
    else begin
        mon_o = monitor::type_id::create("mon_o",this);
        mon_o.iosel = 1'b1;
        `uvm_info(get_name(), "output agent builded", UVM_NONE)
    end   
endfunction: build_phase

function void agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if (is_active == UVM_ACTIVE) begin
        api = mon_i.api;
        drv.seq_item_port.connect(sqr.seq_item_export);
    end
    else begin
        apo = mon_o.apo;
    end
    
endfunction: connect_phase


`endif 