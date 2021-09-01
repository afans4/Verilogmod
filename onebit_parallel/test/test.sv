//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : test
//Create  : 2021-08-17
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ps/1ps

module test;
    reg clk;
    initial begin
        clk = 0;
        #100;
        $stop();
    end
    always @(clk) begin
        #5clk <= ~clk;
    end

    initial begin
        $monitor($time,":clk = %0b",clk);
    end
endmodule//test