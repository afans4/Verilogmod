//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : tb_top
//Create  : 2021-08-24
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ps/1ps

module dut_tb;

    // Parameters
    localparam  N = 128;
  
    // Ports
    reg clk = 0;
    reg rstn = 0;
    reg signed [0:4] c;

    initial begin
        for (int i=0; i<7; ++i) begin
            fork
                automatic int k = i;
                $display("%0d",k);
            join_none
        end
        #100;
        $stop();
    end
  
    always
      #5  clk = ! clk ;
  
  endmodule
  