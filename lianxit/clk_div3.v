//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : clk_div3
//Create  : 2021-08-09
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------

module clk_div3(
    input iclk,
    input rstn,
    output oclk);

    reg [1:0] cnt_p,cnt_n;
    always @(posedge iclk or negedge rstn) begin
        if (!rstn) begin
            cnt_p <= 2'b00;
        end else begin
            cnt_p <= (cnt_p == 2) ? 2'b00 :cnt_p+1'b1 ;
        end
    end

    always @(negedge iclk or negedge rstn) begin
        if (!rstn) begin
            cnt_n <= 2'b00;
        end else begin
            cnt_n <= (cnt_n == 2'd2) ? 2'b00 : cnt_n + 1'b1;
        end
    end

    reg oclk_r;
    always @(iclk or rstn) begin
        if (!rstn) begin
            oclk_r <= 0;
        end else begin
            oclk_r <= ({cnt_p,cnt_n} == 4'b0000||{cnt_p,cnt_n}==4'b0110)
                        ? ~oclk_r : oclk_r;
        end
    end
    assign oclk = oclk_r;
endmodule//clk_div3(