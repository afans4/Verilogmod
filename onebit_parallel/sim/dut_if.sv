`ifndef DUT_IF
`define DUT_IF

//  Interface: dut_if
//
interface dut_if(
        input clk,
        input rst_n
    );
    logic           x_re;
    logic           x_im;
    logic           en;
    logic   [31:0]  y_im;
    logic   [31:0]  y_re;
    logic           valid;

    //clocking cb @(posedge clk);
        
    
endinterface: dut_if
`endif 