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
    input data_en,
    input signed [31:0] data_i,
    input signed [31:0] data_q,
    output [64:0] absma,
    output [8:0] index);

    parameter N = 128;
    reg [64:0] absma_r;
    reg [8:0] index_r,ind_max_r;

    wire signed [64:0] abscu;
    wire updata;

    assign abscu = data_i*data_i+data_q*data_q;
    assign updata = abscu > absma_r;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            absma_r <= 0;
        end
        else if (data_en) begin
            absma_r <= (updata) ? abscu : absma_r;
        end
    end

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            index_r <= 0;
            ind_max_r <= 0;
        end else if (data_en) begin
            index_r <= index_r + 1;
            ind_max_r <= updata ? index_r : ind_max_r;
        end
    end

    assign absma = absma_r;
    assign index = ind_max_r;

endmodule//dut

