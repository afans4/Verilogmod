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

module crc4 (
    input  clk,
    input  rst_n,
    input  data,
    input  data_valid,
    input  crc_start, //CRC开始信号，持续一个clk
    output wire crc_out,  //crc 串行输出
    output reg crc_valid //CRC valid
);

    //G(D)=D4+D3+1
    parameter [4:0] G = 5'b11001;
    reg [3:0] shift_r;
    wire shift_i;
    reg [1:0] cnt;
    reg flag;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 0;
            flag <= 0;
        end
        else if (crc_start) begin
            flag <= 1;
            cnt <= 0;
        end
        else if(!data_valid && flag)begin
            cnt <= (cnt == 3) ? cnt : cnt +1 ;
        end  
    end

    assign shift_i = data_valid ? data : 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n || crc_start) begin
            shift_r <= 4'b0000;
        end else if (data_valid || cnt < 3) begin
            shift_r[0] <= shift_i^shift_r[3]; 
            shift_r[1] <= shift_r[0];
            shift_r[2] <= shift_r[1];
            shift_r[3] <= shift_r[2]^shift_r[3];
        end
    end

    reg [2:0] cnt_o;
    reg flag_o;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_o <= 3'd0;
        end else if (cnt == 3) begin
            cnt_o <= 3'd0;
        end else begin
            cnt_o <= (cnt_o == 3) ? cnt_o : cnt_o+1;
        end
    end

    assign crc_out = shift_r[cnt_o];
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            crc_valid <= 0;
        end else begin
            crc_valid <= 
        end
    end



    

endmodule //crc4

