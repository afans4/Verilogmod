`timescale 1ns/1ns
//  Module: text
module text;
  reg [7:0] a,b;
  initial
  begin
    a = 100;
    b = 200;
    #0 $display("%0t,a = %0d,b = %0d",$time,a,b);
    #10ns;
    a = 10;
    #0 $display("%0t,a = %0d,b = %0d",$time,a,b);
    #10ns;
    b <= a;
    #10 $display("%0t,a = %0d,b = %0d",$time,a,b);
  end

  initial
  begin
    #20ns;
    b <= 50;
    #0 $display("%0t,a = %0d,b = %0d",$time,a,b);
  end
endmodule

