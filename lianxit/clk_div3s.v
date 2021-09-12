//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : clk_div3s
//Create  : 2021-09-10
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module clk_div3s(
    input iclk,
    input rstn,
    output oclk);

    reg [2:0] shift_p,shift_n;
    always @(posedge iclk or negedge rstn) begin
        if (!rstn) begin
            shift_p <= 3'b100;
        end else begin
            shift_p <= {shift_p[0],shift_p[2:1]};
        end
    end

    always @(negedge iclk or negedge rstn) begin
        if (!rstn) begin
            shift_n <= 3'b100;
        end else begin
            shift_n <= {shift_p[0],shift_p[2:1]};
        end
    end
    reg oclk_r;
    assign reve_p = shift_p[2] && shift_n[2];
    assign reve_n = shift_p[1] && shift_n[0];
    always @(iclk or rstn) begin
        if (!rstn) begin
            oclk_r <= 0;
        end else begin
            oclk_r <= (reve_p || reve_n) ? ~oclk_r : oclk_r;
        end
    end
    assign oclk = oclk_r;

endmodule//clk_div3s