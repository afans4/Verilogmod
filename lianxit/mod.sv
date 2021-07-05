//clk gener
initial begin
    clk  = 0;
    forever #10 clk = ~clk;
end