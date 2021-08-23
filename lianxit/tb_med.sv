//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : tb_med
//Create  : 2021-08-12
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ps/1ps
module tb_med;
    logic [2:0] data0,data1,data2;
    logic [2:0] outdata;
    //logic com_01,com_02,com_12;
    med dut(
        .data0(data0),
        .data1(data1),
        .data2(data2),
        .data_med(outdata)
    );
    logic [5:0] cont;
    initial begin
        data0 = 3'd0;
        data1 = 3'd0;
        data2 = 3'd0;
        cont = 6'd0;
        #10;
        for (int i=0; i<64; ++i) begin
            cont <= cont + 6'd1;
            {data0[1:0],data1[1:0],data2[1:0]} <= cont;
            $display("%0d,%0d,%0d,med = %0d",data0,data1,data2,outdata);
            #20;
        end
        $stop();
    end
endmodule//tb_med