//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : top_tb
//Create  : 2021-08-17
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
`timescale 1ns/1ps
`include "head.svh"

module top_tb;
    reg clk;
    reg rst_n;
    logic x_re,x_im;
    logic en;
    logic signed [31:0] y_re;
    logic signed [31:0] y_im;
    logic valid;

    dut_if mif(clk,rst_n);

    my_dut  my_DUT( .clk(clk),
                    .rst_n(rst_n),
                    .en(mif.en),
                    .x_re(mif.x_re),
                    .x_im(mif.x_im),
                    .y_IM(mif.y_im),
                    .y_RE(mif.y_re),
                    .valid(mif.valid));	
                    
    //clk general
    initial begin
        clk = 0;
        forever begin
            #100 clk = ~clk;
        end
    end

    initial begin
        rst_n = 0;
        $display("top_tb:rst_n = %0b,clk = %0b",mif.rst_n,mif.clk);
        //$display("top_tb:rst_n = %0b,clk = %0b",mif.rst_n,mif.clk);
        #1000;
        $display("top_tb:rst_n = %0b",rst_n);
        rst_n = 1;
    end

    //uvm run
    initial begin
        run_test();
    end
    //
    initial begin
        //my_drive 
		uvm_config_db#(virtual dut_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", mif);
		//输入接口监控
		uvm_config_db#(virtual dut_if)::set(null, "uvm_test_top.env.i_agt.mon_i", "vif", mif);
		//输出接口监控
		uvm_config_db#(virtual dut_if)::set(null, "uvm_test_top.env.o_agt.mon_o", "vif", mif);
    end

endmodule//top_tb


