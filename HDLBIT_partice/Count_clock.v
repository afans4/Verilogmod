module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    reg [7:0] s,m,h;
    reg p;
    wire co_s,co_m;
    assign co_s=(s==8'h59);
    assign co_m=co_s&(m==8'h59);
    always @ (posedge clk) begin
        if (reset==1) begin
            //co_s=0;
            s=0;
        end
        else begin
            //co_s=0;
            if (ena==1) begin
                if (s[3:0]==9) begin
                    s[3:0]=0;
                    if (s[7:4]==5) begin
                        s[7:4]=0;
                        //co_s=1;
                    end
                    else
                        s[7:4]=s[7:4]+1;
                end
                else
                    s[3:0]=s[3:0]+1;
            end
        end
    end
    always @ (posedge clk) begin
        if (reset==1) begin
            //co_m=0;
            m=0;
        end
        else begin
            //co_m=0;
            if (ena==1&&(co_s==1)) begin
                if (m[3:0]==9) begin
                    m[3:0]=0;
                    if (m[7:4]==5) begin
                        m[7:4]=0;
                        //co_m=1;
                    end
                    else
                        m[7:4]=m[7:4]+1;
                end
                else
                    m[3:0]=m[3:0]+1;
            end
        end
    end
    always @ (posedge clk) begin
        if (reset==1) 
            h=8'h12;
        else begin
            if ((ena==1)&&(co_m==1)) begin
                if (h[3:0]==9) begin
                    h[3:0]=0;
                    if (h[7:4]==0) 
                        h[7:4]=1;
                    else
                        h[7:4]=0;
                end
                else if ((h[7:4]==1)&&(h[3:0]==2)) 
                    h=1;
                else
                    h[3:0]=h[3:0]+1;
            end
        end
    end
    always @ (posedge clk) begin
        if (reset==1)
            p=0;
        else if ((ena==1)&&(co_m==1)&&(h==8'h11))
                 p=~p;
    end
            
    assign hh=h,mm=m,ss=s;
    assign pm=p;
endmodule
