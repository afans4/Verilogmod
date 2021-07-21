`timescale 1ps/1ps
module tb_seq10010;

    logic clk;
    logic rstn;
    logic data;
    logic seq;
    seq10010 dut(
        clk,
        rstn,
        data,
        seq
    );

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    bit seqq[10] = '{0,1,0,0,1,0,0,1,0,1};
    initial begin
        rstn = 0;
        #100
        rstn <= 1;
        data <= 0;
        @(posedge clk);
        foreach (seqq[i]) begin
            data <= seqq[i];
            @(posedge clk);
        end
        repeat(5) @(posedge clk);
        $stop();
    end    
endmodule