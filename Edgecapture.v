module top_module (
    input clk,
    input reset,
    input [31:0] in,
    output [31:0] out
);
    reg [31:0] old,tep,result;
    initial tep=0;
    always @ (posedge clk) begin
        if (reset==1) begin
            out=0;
            old=in;
            result=0;
        end
        else begin
            tep=(~in&old);
            result=result|tep;
            out=result;
            old=in;
        end
    end
endmodule
