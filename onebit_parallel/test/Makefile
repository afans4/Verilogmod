UVM_DPI_HOME = D:/modeltech64_10.4/uvm-1.2/win64
UVM_HOME     = D:/modeltech64_10.4/verilog_src/uvm-1.2

sim_libb = -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF 

all: work rtl sim run_uvm

work:
	vlib work

rtl:
	vlog ./../dut/*.v 
	vlog ./../dut/*.sv 

sim:
	vlog +incdir+$(UVM_HOME)/src \
	$(UVM_HOME)/src/uvm_pkg.sv \
	./../C/RadarDataGen.c \
	./../dut/*.v \
	./../dut/*.sv \
	./../sim/top_tb.sv 

run:
	vsim -l sim.log -c -novopt -sv_lib work work.top_tb

run_uvm:
	vsim -l sim.log \
	-voptargs=+acc -t ns \
	-do "run -all;exit" \
	-novopt -c -sv_lib \
	$(UVM_DPI_HOME)/uvm_dpi \
	+UVM_TESTNAME=my_case0 \
	-L work \
	work.top_tb

wave:
	add wave top_tb/*
clean:
	rm -r work 