//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : dut
//Create  : 2021-08-24
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module dut(
    input clk,
    input rstn,
    input din,
    output reg dout);

    reg a,b,c;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dout <= 0;
        end else begin
            dout <= din;
        end
    end
    assign d = dout;
    always @(posedge clk or negedge rstn ) begin
        if (!rstn) begin
            b <= 0;
        end else begin
            b <= d;
        end
    end

endmodule//dut

