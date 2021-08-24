`ifndef MY_AGENT__SV
`define MY_AGENT__SV

class my_agent extends uvm_agent;

   my_sequencer  sqr;
   my_driver     drv;
   my_monitor_i    mon_i;
   my_monitor_o    mon_o;
   
   uvm_analysis_port #(my_transaction_i)  api;
   uvm_analysis_port #(my_transaction_o)  apo;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction 
   
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);

   `uvm_component_utils(my_agent)
endclass 

	function void my_agent::build_phase(uvm_phase phase);
	   super.build_phase(phase);
	   if (is_active == UVM_ACTIVE) begin
	       sqr = my_sequencer::type_id::create("sqr", this);
		   drv = my_driver::type_id::create("drv", this);
		   mon_i = my_monitor_i::type_id::create("mon_i",this);
	   end
	   else begin
		   mon_o = my_monitor_o::type_id::create("mon_o",this);
	   end

	endfunction 

	function void my_agent::connect_phase(uvm_phase phase);
	   super.connect_phase(phase);
	   if (is_active == UVM_ACTIVE) begin
			  api = mon_i.ap;
			  drv.seq_item_port.connect(sqr.seq_item_export);//seq_item_export is uvm_sequencer member
	   end
	   else begin
		      apo = mon_o.ap;
	   end	 
	endfunction

`endif
