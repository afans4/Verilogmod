module dut(
    input clk,
    input rstn,
    output reg o);

    reg [2:0] cnt;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            cnt <= 3'h0;
        end else if (~o)begin
            cnt <= cnt+1'h1;
        end
    end
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            o <= 0;
        end else begin
            o <= cnt == 3'h7;
        end
    end

endmodule