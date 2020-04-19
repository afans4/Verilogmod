module top_module (
    input clk,
    input enable,
    input S,
    input A, B, C,
    output Z ); 
    reg [7:0] q;
    reg [2:0] sel;
    always @ (posedge clk) begin
        if (enable==1) begin
            q=q<<1;
            q[0]=S;
        end
        else
            q=q;
    end
    always
        sel={A,B,C};
    assign Z=q[sel];
endmodule
