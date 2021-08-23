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
`include "transaction_i.sv"
module test;
    initial begin
        transaction_i tr;
        tr = new();
        assert (tr.randomize())
        else $error(0,"transaction_i randomize failed");

        tr.my_print();

    end
endmodule//test