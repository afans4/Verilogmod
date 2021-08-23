//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : clk_div3_nocnt
//Create  : 2021-08-19
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module clk_div3_nocnt(
    input clk,
    input rstn,
    output oclk
);

    reg [2:0] d_r;

    always @(clk or rstn) begin
        if (!rstn) begin
            d_r<= 3'b001;
        end
        else begin
            d_r[2] <= d_r[1];
            d_r[1] <= d_r[0];
            d_r[0] <= d_r[2];
        end
    end

    reg oclk_r;
    always @(clk or rstn) begin
        if(!rstn) begin
            oclk_r <= 0;
        end
        else begin
            oclk_r <= d_r[2] ? ~oclk_r : oclk_r;
        end
    end
    assign oclk = oclk_r;

endmodule//clk_div3_nocnt