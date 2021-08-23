`ifndef MONITOR_SV
`define MONITOR_SV

class monitor extends uvm_monitor;
    
    virtual dut_if vif;
    transaction_i tr_i;
    transaction_o tr_o;
    bit  iosel; //
    `uvm_component_utils(monitor);

    uvm_analysis_port #(transaction_i) api;
    uvm_analysis_port #(transaction_o) apo;

    function new(string name = "monitor", uvm_component parent);
        super.new(name, parent);
        iosel = 1'b0;
    endfunction

    //  Function: build_phase
    extern virtual function void build_phase(uvm_phase phase);
    //  Function: main_phase
    extern task main_phase(uvm_phase phase);
    extern task collect_one_pkt();
endclass

function void monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual dut_if)::get(this, "", "vif", vif)) begin
        `uvm_fatal(get_name(), "virtual interface must be set for vif!!!")
    end
    if (!iosel) begin
        api = new("api",this);
        `uvm_info(get_name(), "input monitor builded", UVM_NONE)
    end else begin
        apo = new("apo", this);
        `uvm_info(get_name(), "output monitor builded", UVM_NONE)
    end
    
endfunction: build_phase


task monitor::main_phase(uvm_phase phase);
    while (1) begin
        if (!iosel) begin
            tr_i = new("tr_i");
            collect_one_pkt(); // 捕获输入数据
            api.write(tr_i); 
        end else begin
            tr_o = new("tr_o");
            collect_one_pkt(); // 捕获输入数据
            apo.write(tr_o); 
        end

    end
endtask: main_phase

task monitor::collect_one_pkt();
    bit Redata_q[$];
    bit Imdata_q[$];
    
    //等待有效信号到来
    if(!iosel) begin
        while (1) begin
            @(posedge vif.clk);
            if(vif.en) break;
        end
    end
    else begin
        while (1) begin
            @(posedge vif.clk);
            if(vif.en) break;
        end
    end

    if(!iosel) begin
        `uvm_info(get_name(), "begin to collect input data ", UVM_NONE)
    end
    else begin
        `uvm_info(get_name(), "begin to collect output data", UVM_NONE)
    end
        if(!iosel) begin
            while (vif.en) begin
                Redata_q.push_back(vif.x_re);
                Imdata_q.push_back(vif.x_im);
                @(posedge vif.clk);
            end
        end
        else begin
            while (vif.valid) begin
                Redata_q.push_back(vif.y_re);
                Imdata_q.push_back(vif.y_im);
                @(posedge vif.clk);
            end
        end
    if (!iosel) begin
        tr_i.Re_data = new[Redata_q.size()];
        tr_i.Im_data = new[Imdata_q.size()];
        for (int i=0; i<Redata_q.size(); ++i) begin
            tr_i.Re_data[i] = Redata_q.pop_front();
        end
        for (int i=0; i<Imdata_q.size(); ++i) begin
            tr_i.Im_data[i] = Imdata_q.pop_front();
        end
    end 
    else begin
        tr_o.Re_data = new[Redata_q.size()];
        tr_o.Im_data = new[Imdata_q.size()];
        for (int i=0; i<Redata_q.size(); ++i) begin
            tr_o.Re_data[i] = Redata_q.pop_front();
        end
        for (int i=0; i<Imdata_q.size(); ++i) begin
            tr_o.Im_data[i] = Imdata_q.pop_front();
        end
    end
    if(!iosel) begin
        `uvm_info(get_name(), "end collect input data ", UVM_NONE)
    end
    else begin
        `uvm_info(get_name(), "end collect output data", UVM_NONE)
    end
    
endtask


`endif