module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
	
	reg[2:0] state, next_state;
	parameter left_pos = 0, right_pos = 1 , ah_pos = 2;
	parameter left = 3'b001, right = 3'b010, ah = 3'b100;
	reg faxiang;
	always @(*) begin : proc_1
		 case (1'b1)
            state[left_pos]: begin
            	aaah <= 1'b0;
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                faxiang <= 1'b0;
                if (ground == 0) next_state = ah;
                else if (bump_left == 1 ) next_state = right;
                else next_state = left;
            end
            state[right_pos]: begin
                aaah <= 1'b0;
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                faxiang <= 1'b1;
                if (ground == 0) next_state = ah;
                else if (bump_right == 1 ) next_state = left;
                else next_state = right;
            end
            state[ah_pos]: begin
                aaah <= 1'b1;
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                if (ground == 0) next_state = ah;
                else if (faxiang == 0 ) next_state = left;
                else next_state = right;
            end
        endcase
	end

	always @(posedge clk, posedge areset) begin
        if (areset == 1) state = left ;
        else state = next_state;
    end
endmodule
