module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    reg [31:0] q0,q1;
    always @ (posedge clk) begin
        if (reset==1)
            q1=31'h1;
        else begin
            q0=q1;
            q1=q0>>1;
            q1[31]=q0[0]^1'b0;
            q1[21]=q0[0]^q0[22];
            q1[1]=q0[0]^q0[2];
            q1[0]=q0[0]^q0[1];
        end
    end 
    assign q=q1;
endmodule
