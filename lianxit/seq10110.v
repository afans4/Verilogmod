module seq10110(
    input clk,
    input reset,
    input idata,
    input data_en,
    output reg seqen,
    output aseqen);
    
    localparam  IDLE   = 3'b000,
                S1     = 3'b001,
                S10    = 3'b010,
                S101   = 3'b011,
                S1011  = 3'b100;
                //S10110 = 3'b101;

    reg [2:0] state,nstate;
    // state transition
    always @ (posedge clk or reset) begin
        if (reset) begin
            state <= IDLE;   
            nstate <= IDLE;      
        end else if (data_en) begin
            state <= nstate;
        end else begin
            state <= state;
        end
    end

    //nstate generate
    always @( idata or state) begin
        case (state)
            IDLE: nstate = (idata) ? S1 : IDLE;
            S1: nstate = idata ? S1 : S10;
            S10: nstate = idata ? S101 : IDLE;
            S101: nstate = idata ? S1011: S10;
            S1011: nstate = idata ? S1 : S10;
        endcase
    end
    //seqen asynchronization
    assign aseqen = data_en && (state == S1011) && (idata == 0);
    
    //seqen synchronization
    always @(posedge clk  or reset) begin
        if (reset) begin
            seqen <= 0;
        end else begin
            seqen <= (state == S1011) && (idata == 0);
        end
    end
endmodule
