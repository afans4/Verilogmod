module vend_machine(
    input clk,
    input rst_n,
    input coin_5,
    input coin_10,
    input drink_5,
    input drink_10,
    output reg [1:0] drinko,
    output reg chang);
    
    
    //边沿检测
    wire acoin_5,acoin_10,adrink_5,adrink_10;
    reg [3:0] tri_1,tri_2;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tri_1 <= 4'b0000;
            tri_2 <= 4'b0000;
        end else begin
            tri_1 <= {coin_5,coin_10,drink_5,drink_10};
            tri_2 <= tri_1;
        end
    end
    assign acoin_5 = (~tri_2[3]) & tri_1[3];
    assign acoin_10 = (~tri_2[2]) & tri_1[2];
    assign adrink_5 = (~tri_2[1]) & tri_1[1];
    assign adrink_10 = (~tri_2[0]) & tri_1[0];
    //state 
    parameter IDLE = 4'b0001,
              S0   = 4'b0010,
              S1   = 4'b0100,
              S2   = 4'b1000;

    reg [3:0] state,nstate;
    reg [1:0] drink;
    reg [1:0] coin;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            nstate <= IDLE;
        end else begin
            state <= nstate;
        end
    end
    wire en_drink,en_coin;
    assign en_drink = adrink_5 | adrink_10;
    assign en_coin = acoin_5 | acoin_10; 
    assign coin_eng = drink <= coin;
    always @( *) begin
        case (state)
            IDLE: nstate = en_drink ? S0 : IDLE;
            S0: nstate = en_coin ? S1 : S0;
            S1: nstate = coin_eng ? S2 : S1;
            S2: nstate = IDLE;
            default : nstate = IDLE;      
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            drink <= 0;
            coin  <= 0;
        end else begin
            case (nstate)
                IDLE:begin
                    drink  <= 0;
                    coin <= 0;
                    drinko <= 0;
                    chang <= 0;
                end
                S0: begin
                    drink <= drink+{adrink_10,adrink_5};
                    coin <= 0;
                end
                S1: begin
                    if (acoin_5)
                        coin <= coin + 1;
                    else if (acoin_10) 
                        coin <= coin + 2;        
                end
                S2: begin
                    drinko <= drink;
                    chang <= (drink < coin);
                end
                default: begin
                    drink <= 0;
                    coin <= 0;
                    chang <= 0;
                    drinko <=0;
                end
            endcase
        end
    end
endmodule //vend_machine