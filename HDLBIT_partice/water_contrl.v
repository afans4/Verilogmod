module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
	reg [3:1] next_state,state;
	reg [3:0] key;
	always @ (posedge clk)begin
		if (reset == 1) state = 3'b000;
		else state = next_state;
	end

	always @ (*) begin
		case (state)
			3'b000:key[2:0]=3'b111;
			3'b001:key[2:0]=3'b011;
			3'b011:key[2:0]=3'b001;
			3'b111:key[2:0]=3'b000;
			default:key[2:0] = 3'b000;
		endcase
		next_state = s;
	end
	
	always @(posedge clk)begin
        if (reset || state < next_state)
            key[3] <= 1'b0;
        else if (state > next_state)
            key[3] <= 1'b1;
    end

	assign dfr = (state == 3'b000) || key[3];
	assign {fr3,fr2,fr1} = key[2:0];
endmodule
