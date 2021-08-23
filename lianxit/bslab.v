//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : bslab
//Create  : 2021-08-21
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module bslab(
    input clk,
    input set,
    input din,
    input rst_n,
    output dout);

    reg d_r;
    assign dout = set ? d_r : 1'b1;
    wire d_in;
    assign d_in = ~(dout^din);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            d_r <= 1'b0;
        end else begin
            d_r <= d_in;
        end
    end

endmodule//bslab