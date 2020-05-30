module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    // parameter LEFT=0, RIGHT=1, ...
    reg state, next_state;
    parameter left = 1'b0,right = 1'b1;

    always @(*) begin
        case (state)
            left: begin
                walk_left = 1'b1;
                if (bump_left == 1 ) next_state = right;
                else next_state = left;
            end
            right: begin
                walk_left = 1'b0;
                if (bump_right == 1) next_state = left ;
                else next_state = right;
            end
        endcase
        walk_right = ~walk_left;
    end

    always @(posedge clk, posedge areset) begin
        if (areset == 1) state = left ;
        else state = next_state;
    end

    // Output logic
    // assign walk_left = (state == ...);
    // assign walk_right = (state == ...);

endmodule
