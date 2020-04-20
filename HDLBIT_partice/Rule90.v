module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q ); 
	integer i;
    reg [511:0] q1;
    always @ (posedge clk) begin
        if (load==1)
            q1=data;
        else begin
        q1[0]=1'b0^q[1];
        q1[511]=1'b0^q[510];
        for (i=1;i<511;i=i+1) begin
            q1[i]=q[i-1]^q[i+1];
        end
        end
    end
    assign q=q1;
endmodule
