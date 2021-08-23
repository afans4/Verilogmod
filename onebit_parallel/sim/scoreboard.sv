`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

class scoreboard extends uvm_scoreboard;
    transaction_o expect_queue[$];
    uvm_blocking_get_port #(transaction_o) exp_port;
    uvm_blocking_get_port #(transaction_o) act_port;
    `uvm_component_utils(scoreboard);

    function new(string name = "scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction

    //  Function: build_phase
    extern virtual function void build_phase(uvm_phase phase);
    //  Function: main_phase
    extern task main_phase(uvm_phase phase);
    
endclass

function void scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp_port = new("exp_port", this);
    act_port = new("act_port", this);
    `uvm_info(get_name(), "scoreboard builded", UVM_NONE)
endfunction: build_phase

task scoreboard::main_phase(uvm_phase phase);
    transaction_o   get_expect,get_actual,tmp_tran;
    bit result;
    super.main_phase(phase);

    fork
        while (1) begin
            exp_port.get(get_expect);
            expect_queue.push_back(get_expect);
        end

        while (1) begin
            act_port.get(get_actual);
            if (expect_queue.size() > 0) begin
                tmp_tran = expect_queue.pop_front();
                result = get_actual.compare(tmp_tran);
                if (result) begin
                    `uvm_info(get_name(), "Compare SUCCESSFULLY", UVM_NONE) 
                end
                else begin
                    `uvm_error(get_name(), "Compare FAILED");
                    $display("the expect tra is:");
                    tmp_tran.print();
                    $display("the actual tra is:");
                    get_actual.print();
                end
            end
            else begin
                `uvm_info(get_name(), "Received from DUT,while Expect Queue is Empty", UVM_NONE)  
            end
        end
    join
endtask: main_phase


`endif