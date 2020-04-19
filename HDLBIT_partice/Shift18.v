module top_module(
    input clk,
    input load,
    input ena,
    input [1:0] amount,
    input [63:0] data,
    output reg [63:0] q); 
    reg fh;
    always @ (posedge clk) begin
        if (load==1)
            q=data;
        else if (ena==1) begin
            fh=q[63];
            if(amount==2'b00) begin
                q=q<<1;
                //q[63]=fh&(|q[62:0]);
            end
            else if (amount==2'b01) begin
                q=q<<8;
                //q[63]=fh&(|q[62:0]);
            end
            else if (amount==2'b10) begin
                q=q>>1;
                q[63]=fh;
            end
            else if (amount==2'b11) begin
                q=q>>8;
                if (fh==1)
                    q[63:55]=8'hff;
                else
                    q[63:55]=8'h00;
                q[63]=fh;
            end
        end
    end
endmodule
