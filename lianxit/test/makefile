all: work rtl tb run

work:
	vlib work

rtl:
	vlog dut.v

tb:
	vlog tb_top.sv

run:
	vsim -c -novopt \
	-do "run -all;exit" \
	work.tb_top

clr:
	rm -r work