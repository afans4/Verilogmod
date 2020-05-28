// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        case (state) 
            A: next_state = in ? A : B ;
            B: next_state = in ? B : A ;
            default : next_state = 1'bz;
        endcase
        case (state) 
            A: out = 0 ;
            B: out = 1 ;
            default : next_state = 1'bz;
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        if (reset == 1) state = B ;
        else state = next_state;
    end

endmodule
