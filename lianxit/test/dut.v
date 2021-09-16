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

module dut (
    input  clk,
    input  rstn,
    input  a,
    input  b,
    output d //CRC valid
);
    reg dr;
    assign d = dr;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            dr <= 1'b0;
        end else if (a & b ) begin
            dr <= a+b;
        end else begin
            dr <= 1'b0;
        end
     end
endmodule

