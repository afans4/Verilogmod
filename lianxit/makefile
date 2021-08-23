all: work rtl tb sim

work:
	rm -r work
	vlib work

rtl:
	vlog clk_div3_nocnt.sv

tb:
	vlog tb_clk_div3.sv

sim:
	vsim -novopt work.tb_clk_div3