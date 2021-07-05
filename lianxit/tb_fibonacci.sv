`timescale 1ps/1ps
//  Module: tb_fibonacci
//
module tb_fibonacci;

    reg clk;
    reg reset;
    reg [7:0] nth;
    reg start;
    wire [19:0] result;
    wire out_en;
    fibonacci dut (
                    clk,
                    reset,
                    nth,
                    start,
                    result,
                    out_en);

    //clk general
    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        bit [19:0] ref_result;
        reset = 1;
        start = 0;
        nth = 10;
        ref_result = cal_fib(nth);
        #100 reset = 0;
        start = 1;
        $display("\n%m\n[INFO] %0t: cal begin", $realtime);
        #20 start = 0;
        $display("[INFO] %0t:nth = %0d",$realtime,nth);
        @(posedge out_en)
        $display("[INFO] %0t:result = %0d",$realtime,result);
        $display("[INFO] %0t:ref_result = %0d",$realtime,ref_result);
        #100
        nth = 1;
        ref_result = cal_fib(nth);
        #20 start = 1;
        $display("[INFO] %0t: cal begin", $realtime);
        #20 start = 0;
        $display("[INFO] %0t:nth = %0d",$realtime,nth);
        #10
        wait(out_en);
        $display("[INFO] %0t:result = %0d",$realtime,result);
        $display("[INFO] %0t:ref_result = %0d",$realtime,ref_result);
        #100
        nth = 5;
        ref_result = cal_fib(nth);
        $display("[INFO] %0t: cal begin", $realtime);
        #20 start = 1;
        $display("[INFO] %0t:nth = %0d",$realtime,nth);
        #20 start = 0;
        #10
        wait(out_en);
        $display("[INFO] %0t:result = %0d",$realtime,result);
        $display("[INFO] %0t:ref_result = %d",$realtime,ref_result);
        #100
        $stop();
    end

    function bit [19:0] cal_fib(bit[7:0] ntt);
        bit [19:0] temp,a0,a1,at;
        temp = 0;
        a0 = 0;
        a1 = 1;
        at = 0;
        while(ntt) begin
            temp = temp+a1;
            at = a1+a0;
            a0 = a1;
            a1 = at;
            ntt = ntt-1;
        end
        return temp;
    endfunction
endmodule: tb_fibonacci
