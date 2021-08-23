//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : tb_clk_div3
//Create  : 2021-08-09
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ps/1ps
module tb_clk_div3;
    logic iclk,rstn,oclk;

    clk_div3_nocnt dut(
        .clk   (iclk),
        .rstn   (rstn),
        .oclk   (oclk)
        );
    initial begin
        iclk = 0;
        forever #10 iclk = ~iclk;
    end
    
    initial begin

        rstn = 0;
        #100
        rstn = 1;

        #500
        $stop();
    end
endmodule//tb_clk_div3