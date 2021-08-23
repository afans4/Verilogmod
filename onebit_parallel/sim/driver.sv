`ifndef DRIVE
`define DRIVE

class driver extends uvm_driver #(transaction_i);
    
    virtual dut_if vif;
    `uvm_component_utils(driver);

    function new(string name = "driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
            `uvm_fatal(get_name(), "virtual vir setting error!!!!")   
        end
        `uvm_info(get_name(), "driver builded", UVM_NONE)
        
    endfunction: build_phase
    
    //  Function: main_phase
    extern task main_phase(uvm_phase phase);
    extern task drive_one_pkt(transaction_i tr);
endclass

task driver::main_phase(uvm_phase phase);
    
    vif.x_re    <= 1'b0;
    vif.x_im    <= 1'b0;
    vif.en      <= 1'b0;
    `uvm_info(get_name(), "drv wait singed rst_n", UVM_NONE)
    $display("rst_n = %0b",vif.rst_n);
    while (!vif.rst_n) begin
        @(posedge vif.clk);
    end
    `uvm_info(get_name(), "rst_n disen", UVM_NONE)
    while(1) begin
        `uvm_info(get_name(), "drv wait one seq", UVM_NONE)
        seq_item_port.get_next_item(req);
        `uvm_info(get_name(), "drv get one seq", UVM_NONE)
        drive_one_pkt(req);
        seq_item_port.item_done();    
        `uvm_info(get_name(), "drv end one seq", UVM_NONE)
    end

    
endtask: main_phase

task driver::drive_one_pkt(transaction_i tr);
    bit Redata_q[$];
    bit Imdata_q[$];
    //数据转存入队列
    for (int i=0; i<tr.Re_data.size; ++i) begin
        Redata_q.push_back(tr.Re_data[i]);
        Imdata_q.push_back(tr.Im_data[i]);
    end

    repeat (3) @(posedge vif.clk);
    `uvm_info(get_name(), "begin to drive one pkt", UVM_NONE)
    while (Redata_q.size() > 0) begin
        @(posedge vif.clk);
        vif.en   <= 1'b1;
        vif.x_re <= Redata_q.pop_front();
        vif.x_im <= Imdata_q.pop_front();
    end
    @(posedge vif.clk);
    vif.en <= 1'b0;
    repeat(tr.Re_data.size + 20) @(posedge vif.clk);  // process end
    `uvm_info(get_name(), "end drive one pkt", UVM_NONE)
    
    
endtask


`endif 