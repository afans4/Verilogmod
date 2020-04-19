module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg [3:0] q;
    always @ (posedge clk) begin
        if (resetn==0)
            q=4'b0000;
        else begin
            q[0]<=in;
            q[1]<=q[0];
            q[2]<=q[1];
            q[3]<=q[2];
            out<=q[3];
        end
    end
    
endmodule
