module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 

    reg[3:0] state, next_state;
    parameter left_pos = 0, right_pos = 1, 
              ah_pos = 2,di_pos = 3;
    parameter left = 4'b0001,
              right = 4'b0010,
              ah = 4'b0100,
              di = 4'b1000;
    reg faxiang;

    always @(*) begin : proc_1
        case (1'b1)
            state[left_pos]: begin
                aaah <= 1'b0;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                digging <= 1'b0;
                faxiang <= 1'b0;
                if (ground == 0) next_state = ah;
                else if (dig == 1) next_state = di;
                else if (bump_left == 1) next_state = right;
                else next_state = left;    
            end
            state[right_pos]: begin
                aaah <= 1'b0;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                digging <= 1'b0;
                faxiang <= 1'b1;
                if (ground == 0) next_state = ah;
                else if (dig == 1) next_state = di;
                else if (bump_right == 1) next_state = left;
                else next_state = right;    
            end 
            state[ah_pos]: begin
                aaah <= 1'b1;
                walk_right <= 1'b0;
                walk_left <= 1'b0;
                digging <= 1'b0;
                if (ground == 0) next_state = ah;
                else if (faxiang == 0) next_state = left;
                else next_state = right;
            end
            state[di_pos]: begin
                aaah <= 1'b0;
                walk_right <= 1'b0;
                walk_left <= 1'b0;
                digging <= 1'b1;
                if (ground == 0) next_state = ah;
                else next_state = di;
            end
        endcase // 1'b1
    end

    always @(posedge clk or posedge areset) begin : proc_state
        if(areset) begin
            state <= left;
        end 
        else begin
            state <= next_state;
        end
    end

endmodule
