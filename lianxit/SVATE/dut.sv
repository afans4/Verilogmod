//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : dut
//Create  : 2021-09-01
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module dut(
    input clk,
    input rstn,
    input idata,
    output reg odata
);
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            odata <= 0;
        end else begin
            odata <= idata;
        end
    end

endmodule//dut