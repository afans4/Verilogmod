`timescale 1ps/1ps
//  Module: text
//
module text;
    typedef struct{
        bit [7:0] opcode;
        bit [23:0] addr;
    } instr_s;
    typedef union {
        bit [7:0] data;
        bit [15:0] f_data;
    } sta_u;

    initial begin
        instr_s isf ;
        isf.opcode= 8'ha8;
        isf.addr = 24'h3afaf1;
        sta_u re;
        re.f_data = 'hcabf;
        #10
        $display("[%t]union display:",$time);
        $display("int_data = %0h",re.data);
        $display("real_data = %h",re.f_data);
        #10
        $display("[%t]struct display:",$realtime);
        $display("opcodea = %0h",isf.opcodea);
        $display("addr = %0h",isf.addr);
        $finish();
    end
    
endmodule: text
