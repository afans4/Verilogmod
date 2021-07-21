module a2b(
    input clka,
    input clkb,
    input pulse_a,
    output pulse_b,
    input rstn
);
    reg a_state;
    always@(posedge clka or negedge rstn) begin
        if (!rstn)
            a_state <= 0;
        else 
            a_state <= pulse_a ? ~a_state : a_state;
    end

    reg ff1,ff2;
    always@(posedge clkb or negedge rstn) begin
        if (!rstn) begin
            ff1 <= 0;
            ff2 <= 0;
        end
        else begin
            ff1 <= a_state;
            ff2 <= ff1;
        end
    end

    assign pulse_b = (ff1!=ff2) ? 1'b1 : 1'b0;
endmodule
