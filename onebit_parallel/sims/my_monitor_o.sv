`ifndef MY_MONITOR_O__SV
`define MY_MONITOR_O__SV
class my_monitor_o extends uvm_monitor;
	virtual my_if vif;
    `uvm_component_utils(my_monitor_o)	
	
	uvm_analysis_port #(my_transaction_o)  ap; 
	
	function new(string name="my_monitor_o", uvm_component parent = null);
		super.new(name,parent);
	endfunction
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_monitor_o", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction_o tr);		
endclass

	task my_monitor_o::main_phase(uvm_phase phase);
	   my_transaction_o tr;
	   while(1) begin
		  tr = new("tr");
		  collect_one_pkt(tr);
		  ap.write(tr);
	   end
	endtask
	task my_monitor_o::collect_one_pkt(my_transaction_o tr);
	    bit [31:0] Redata_q[$];
		bit [31:0] Imdata_q[$];
		
	    int size_R, size_I;
	   
	   while(1) begin
		  @(posedge vif.clk);
		  if(vif.valid) break;
	   end
	   
	   `uvm_info("my_monitor_o", "begin to collect one pkt", UVM_LOW);
	   while(vif.valid) begin
		  Redata_q.push_back(vif.y_RE);
		  Imdata_q.push_back(vif.y_IM); 
		  @(posedge vif.clk);
	   end
	   size_R  = Redata_q.size();   
	   size_I  = Imdata_q.size();   
	   tr.Re_data = new[size_R];
	   tr.Im_data = new[size_I]; 
	   
	   for ( int i = 0; i < size_R; i++ ) begin
		  tr.Re_data[i] = Redata_q.pop_front(); 		  
	   end
	   for ( int i = 0; i < size_I; i++ ) begin
		  tr.Im_data[i] = Imdata_q.pop_front(); 		  
	   end
	   
	   `uvm_info("my_monitor_o", "end collect one pkt", UVM_LOW);
	   //  tr.my_print();
	endtask
`endif