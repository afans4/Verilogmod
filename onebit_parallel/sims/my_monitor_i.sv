`ifndef MY_MONITOR_I__SV
`define MY_MONITOR_I__SV
class my_monitor_i extends uvm_monitor;
	virtual my_if vif;
	`uvm_component_utils(my_monitor_i)
	
	uvm_analysis_port #(my_transaction_i)  ap; 
	
	function new(string name="my_monitor_i", uvm_component parent = null);
		super.new(name,parent);
	endfunction
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual my_if)::get(this, "", "vif", vif))
         `uvm_fatal("my_monitor_i", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);
   extern task collect_one_pkt(my_transaction_i tr);		
endclass

task my_monitor_i::main_phase(uvm_phase phase);
   my_transaction_i tr;
   while(1) begin
	  tr = new("tr");
	  collect_one_pkt(tr);
	  ap.write(tr);
   end
endtask

task my_monitor_i::collect_one_pkt(my_transaction_i tr);
   bit Redata_q[$];
   bit Imdata_q[$];
   int size_I,size_R;
   
   while(1) begin
	  @(posedge vif.clk);
	  if(vif.en) break;
   end
   
   `uvm_info("my_monitor_i", "begin to collect one pkt", UVM_LOW);
   while(vif.en) begin
	  Redata_q.push_back(vif.x_re);
	  Imdata_q.push_back(vif.x_im);
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
   `uvm_info("my_monitor_i", "end collect one pkt", UVM_LOW);
   // tr.my_print();
endtask
`endif