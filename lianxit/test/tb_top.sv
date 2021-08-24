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
module tb_top;
    reg [3:0] d0,d1,d2,d3;
    reg clk;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    initial begin
        d0 = 4'd0;
        d1 = 4'd1;
        d2 = 4'd2;
        d3 = 4'd3;
    end

    always @ (posedge clk) begin
        d1 = d0;
        d2 = d1;
        d3 = d2;
    end
    always @(posedge clk) begin
        d1 <= d0;
        d2 <= d1;
        d3 <= d2;
    end

    initial begin
        $monitor($time,":d0 = %0d,d1 = %0d,d2 = %0d,d3 = %0d",d0,d1,d2,d3);
        #200
        $finish;
    end
endmodule//tb_top