module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    reg [3:0] data;
    assign c_load=(enable&&(data>=12))|reset;
    assign c_d=1;
    assign c_enable=enable;
    count4 the_counter (clk, c_enable, c_load, c_d ,data );
	assign Q=data;
endmodule
