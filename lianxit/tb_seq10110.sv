`timescale 1ps/1ps
module tb_seq10110;
    
    //module exception
    //input
    reg clk,reset,idata,data_en;
    //output
    wire seqen;
    seq10110 seq1(.clk(clk),
                  .reset(reset),
                  .idata(idata),
                  .data_en(data_en),
                  .seqen(seqen));

    //clk general
    initial clk = 0;
    always #10 clk = ~clk;
    
    //
    initial begin
        reset = 1;
        data_en = 1;
        #100 reset = 0;
        idata = 0;
        #20 idata = 1;
        #20 idata = 0;
        #20 idata = 1;
        #20 idata = 1;
        #20 idata = 0;
        #20 idata = 1;
        #20 idata = 1;
        #20 idata = 0;
        #20 idata = 1;
        #100 $stop();

    end
endmodule