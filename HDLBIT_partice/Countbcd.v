module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    reg [15:0] data;
    always @ (posedge clk) begin
        if (reset==1) 
            data=0;
        else begin
            if (data[3:0]==9) begin
                data[3:0]=0;
                if (data[7:4]==9) begin
                    data[7:4]=0;
                    if(data[11:8]==9) begin
                        data[11:8]=0;
                        if (data[15:12]==9)
                            data[15:12]=0;
                        else
                            data[15:12]=data[15:12]+1;
                    end
                    else
                        data[11:8]=data[11:8]+1;
                end
                else
                    data[7:4]=data[7:4]+1;
            end
            else
                data[3:0]=data[3:0]+1;
        end
    end
    assign q=data;
    assign ena[1]=(data[3:0]==9);
    assign ena[2]=(data[7:4]==9)&(data[3:0]==9);
    assign ena[3]=(data[11:8]==9)&(data[7:4]==9)&(data[3:0]==9);
endmodule
