module top_module(
    input clk,
    input load,
    input [511:0] data,
    output [511:0] q
); 
    reg [511:0] q1;
    reg [511:0] q0;
    integer i;
    always @ (posedge clk) begin
        q0=q1;
        if (load==1)
            q1=data;
        else begin
            q1[0]=q0[0];
            q1[511]=q0[511]|q0[510];
            for (i=1;i<511;i=i+1) begin
                q1[i]=(q0[i]^q0[i-1])|(~q0[i+1]&q0[i]);
            end
        end
    end
    assign q=q1;
endmodule
