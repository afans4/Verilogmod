`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;
`include "my_if.sv"
`include "my_transaction_i.sv"
`include "my_transaction_o.sv"
`include "my_sequencer.sv"
`include "my_driver.sv"
`include "my_monitor_i.sv"
`include "my_monitor_o.sv"
`include "my_agent.sv"
`include "my_model.sv"
`include "my_scoreboard.sv"
`include "my_env.sv"
`include "base_test.sv"
`include "my_case0.sv"
`include "my_case1.sv"
module top_tb;


reg clk;
reg rst_n;
reg x_re;
reg x_im;
reg en;
wire signed[31:0] y_IM;
wire signed[31:0] y_RE;
wire valid;

my_if Mif(clk,rst_n);


 mf_top  my_DUT(.clk(clk),
				.rst_n(rst_n),
				.en(Mif.en),
				.x_re(Mif.x_re),
				.x_im(Mif.x_im),
				.y_IM(Mif.y_IM),
				.y_RE(Mif.y_RE),
				.valid(Mif.valid));	 	
	
	//clk general			   
	initial begin
	   clk = 0;
	   forever begin
		  #100 clk = ~clk;
	   end
	end

	//rst 
	initial begin
	   rst_n = 1'b0;
	   $display("top_tb:rst_n = %0b,clk = %0b",Mif.rst_n,Mif.clk);
	   #1000;
	   $display("top_tb:rst_n = %0b,clk = %0b",Mif.rst_n,Mif.clk);
	   rst_n = 1'b1;
	   $display("top_tb:rst_n = %0b,clk = %0b",Mif.rst_n,Mif.clk);
	end
	//uvm run
	initial begin
	   run_test();
	end
	//接口传递
	initial begin
		//my_drive 
		uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.drv", "vif", Mif);
		//输入接口监控
		uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.i_agt.mon_i", "vif", Mif);
		//输出接口监控
		uvm_config_db#(virtual my_if)::set(null, "uvm_test_top.env.o_agt.mon_o", "vif", Mif);
	end	
	
endmodule