

vsim -c -sv_lib $UVM_DPI_HOME/uvm_dpi   -voptargs=+acc -t ns  +UVM_TESTNAME=my_case1 -L work work.top_tb      

add wave	top_tb/my_DUT/*

run 500ms