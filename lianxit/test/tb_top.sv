//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : tb_top
//Create  : 2021-08-24
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ps/1ps

class my_tran;
    rand int data_i[];
    rand int data_q[];
    string name;
    constraint data_cons{
        data_i.size() == 128;
        data_q.size() == 128;
    }

    function new(string name = "my_tran");
        this.name = name;
    endfunction
endclass
module dut_tb;

    // Parameters
    localparam  N = 128;
  
    // Ports
    reg clk = 0;
    reg rstn = 0;
    reg data_en = 0;
    reg [31:0] data_i;
    reg [31:0] data_q;
    wire [64:0] absma;
    wire [8:0] index;
  
    dut 
    #(
      .N (N)
    )
    dut_dut (
      .clk (clk ),
      .rstn (rstn ),
      .data_en (data_en ),
      .data_i (data_i ),
      .data_q (data_q ),
      .absma (absma ),
      .index  ( index)
    );
    my_tran tr;
    initial begin
        tr = new("my_tr");
        assert(tr.randomize());
        data_en = 1;
        rstn = 0;
        #100;
        rstn = 1;
        #10;
        for (int i=0; i<128; ++i) begin
            data_i <= tr.data_i[i];
            data_q <= tr.data_q[i];
            @(posedge clk);
        end
        #100;
        $stop();
    end
  
    always
      #5  clk = ! clk ;
  
  endmodule
  