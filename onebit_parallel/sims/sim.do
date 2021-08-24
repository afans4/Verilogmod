set UVM_DPI_HOME D:/modeltech64_10.4/uvm-1.1d/win64
if [file exists work] {
    vdel -all
}
vlib work

vlog ./../dut/*.v
vlog ./../dut/*.sv
#vlog ./../dut/mf_1bit_512order_Re.sv

vlog  ./../C/RadarDataGen.c

vlog -L mtiAvm -L mtiOvm -L mtiUvm -L mtiUPF  ./top_tb.sv  

vsim -c -l sim.log -sv_lib $UVM_DPI_HOME/uvm_dpi   -voptargs=+acc -t ns  +UVM_TESTNAME=my_case1 -L work work.top_tb      

#add wave	top_tb/my_DUT/*

run 500ms