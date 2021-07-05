module fibonacci (
    input clk,
    input reset,
    input [7:0] nth,
    input start,
    output [19:0] result,
    output out_en);

    localparam IDLE = 4'b0001,
               LOAD = 4'b0010,
               CAL  = 4'b0100,
               OUT  = 4'b1000;

    // state shift
    reg [3:0] state,nstate;
    always @(posedge clk ) begin
        if (reset) begin
            state <= IDLE;
            nstate <= IDLE;
        end else begin
            state <= nstate;
        end
    end
    wire cal_end ;
    always @( *) begin
        case (state)
            IDLE: nstate = (start) ? LOAD : IDLE;
            LOAD: nstate = (nth == 1) ? OUT : CAL;
            CAL:  nstate = (cal_end) ? OUT : CAL;
            OUT: nstate = (start) ? LOAD :OUT;
            default : nstate = state;
        endcase
    end
    
    reg [7:0] nth_temp;
    reg [7:0] num;
    reg [19:0] sum_temp;
    reg [19:0] val_n,val_np;
    always @(posedge clk ) begin
        case (nstate)
            IDLE: begin
                nth_temp <= 0;
                num <= 0;
                sum_temp <= 0;
                val_n <= 0;
                val_np <= 0;
            end
            LOAD: begin
                nth_temp <= nth;
                num <= 1;
                sum_temp <= 1;
                val_n <= 1;
                val_np <= 0;
            end
            CAL: begin
                sum_temp <= sum_temp+val_n+val_np;
                num <= num + 1;
                val_n <= val_np + val_n;
                val_np <= val_n;
            end
            OUT: begin
                
            end
        endcase
    end
    //计算结束标志
    assign cal_end = (num == nth_temp);
    //输出驱动
    assign result = (state == OUT) ? sum_temp : 20'b0;
    assign out_en = (state == OUT);
endmodule //fibonacci