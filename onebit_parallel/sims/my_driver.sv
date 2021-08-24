`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV
//import "DPI-C" function void RadarDataGen(output real data[1024],input int range);

class my_driver extends uvm_driver#(my_transaction_i);
	virtual my_if vif;
	`uvm_component_utils(my_driver)
	function new (string name="my_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction
	
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual my_if)::get(this,"","vif",vif))
			`uvm_fatal("uvm_driver","virtual vif setting error!!!!");
	endfunction
	
	//extern function void data2frame(my_transaction_i tr);
	extern task main_phase(uvm_phase phase);
	extern task drive_one_pkt(my_transaction_i tr);
endclass

	task my_driver::main_phase(uvm_phase phase);
	   
	   vif.x_re <= 1'b0;
	   vif.x_im <= 1'b0;
	   vif.en <= 1'b0;
	   `uvm_info(get_name(), "drv wait singed rst_n", UVM_NONE)
	   $display("rst_n = %0b",vif.rst_n);
	   while(!vif.rst_n)
		  @(posedge vif.clk);
		  `uvm_info(get_name(), "drv disen rst_n", UVM_NONE)
		  $display("rst_n = %0b",vif.rst_n);
	   while(1) begin
		  seq_item_port.get_next_item(req); //seq_item_port is uvm_driver member
		  
		  //req.data = new [1024];    
		  //RadarDataGen(req.data,req.range); //Radar Data Generate by C function
	      //data2frame(req);    // Radar data 1-bit quantitation and sent to frame_data
		  
		  drive_one_pkt(req);
		  seq_item_port.item_done();
	   end	
	endtask

	task my_driver::drive_one_pkt(my_transaction_i tr);
	   bit    Redata_q[$];
	   bit    Imdata_q[$];
	   for(int i = 0; i < tr.Re_data.size; i++) begin  //tr 2 data_q
		  Redata_q.push_back(tr.Re_data[i]);
		  Imdata_q.push_back(tr.Im_data[i]);
	   end

		repeat(3) @(posedge vif.clk);
	   `uvm_info("my_driver", "begin to drive one pkt", UVM_LOW);	   
	    while(Redata_q.size() > 0) begin
			@(posedge vif.clk);
			vif.en <= 1'b1;
			vif.x_re <= Redata_q.pop_front(); 
			vif.x_im <= Imdata_q.pop_front(); 
		end  
			@(posedge vif.clk);  //sent finish
			vif.en <= 1'b0;   
		`uvm_info("my_driver", "end drive one pkt", UVM_LOW);
	   repeat(tr.Re_data.size + 20) @(posedge vif.clk);  // process end
	   
	endtask

    //function void my_driver::data2frame(my_transaction_i tr);
	//		tr.Im_data = new[512];
	//		tr.Re_data = new[512];
	//		for(int i = 0; i<512 ; i++)begin //Re_data
	//			if(tr.data[i]>=0)
	//				tr.Re_data[i] = 1'b0;
	//			else
	//				tr.Re_data[i] = 1'b1;				
	//		end
	//		for(int i = 512 ; i<1024 ; i++)begin
	//			if(tr.data[i]>=0)
	//				tr.Im_data[i] = 1'b0;
	//			else
	//				tr.Im_data[i] = 1'b1;				
	//		end
	//endfunction
`endif

