module seq10010 (
    input clk,
    input rstn,
    input data,
    output seq
);
    reg [2:0] state,nstate;
    parameter S0    = 0,
              S1    = 1,
              S10   = 2,
              S100  = 3,
              S1001 = 4;
    
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            state <= S0;
            nstate <= S0;
        end else
            state <= nstate;
    end

    always @(*) begin
        case (state)
            S0      : nstate = data ? S1 : S0;
            S1      : nstate = data ? S1 : S10;
            S10     : nstate = data ? S1 : S100;
            S100    : nstate = data ? S1001 : S0;
            S1001   : nstate = data ? S1 : S10;
            default : nstate = S0;
        endcase
    end

    assign seq = (state == S1001) & (!data);
endmodule //seq10010