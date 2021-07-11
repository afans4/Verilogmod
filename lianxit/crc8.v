module crc8 (
    input  clk,
    input  rst_n,
    input  data,
    input  data_valid,
    input  crc_start, //CRC开始信号，持续一个clk
    output wire crc_out,  //crc 串行输出
    output reg crc_valid //CRC valid
);

    reg [7:0] shift_reg ;
    reg [7:0] crc8_out;

    parameter IDLE = 3'b001,
              CAL  = 3'b010,
              CRCO = 3'b100;

    reg [2:0] state,nstate;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state  <= IDLE;
            nstate <= IDLE;
        end else begin
            state <= nstate;
        end
    end  
    wire cal_end;
    wire out_end;

    always @( *) begin
        case (state)
            IDLE    : nstate = (crc_start) ? CAL : IDLE;
            CAL     : nstate = (cal_end) ? CRCO : CAL;
            CRCO    : nstate = (out_end) ? IDLE : CRCO;
            default : nstate = IDLE;
        endcase
    end
    reg [5:0] cnt_crc;
    reg [2:0] cnt_out;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_crc <= 0;
        end else if (crc_start) begin
            cnt_crc <= 0;
        end else if (data_valid) begin
            cnt_crc <= cnt_crc + 1;
        end else
            cnt_crc <= cnt_crc;
    end
    assign cal_end = (cnt_crc == 6'd32);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt_out <= 0;
        end else if(nstate == CAL) begin
            cnt_out <= 0;
        end else if (state == CRCO) begin
            cnt_out <= cnt_out + 1;
        end
    end
    assign out_end = (cnt_out == 3'd7);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            crc_valid <= 0;
        end else begin
            crc_valid <= (nstate == CRCO) ? 1 : 0;
        end
    end
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            shift_reg <= 8'h00;
        end else if (crc_start) begin
            shift_reg <= 8'h00;
        end else if (data_valid) begin
            shift_reg[0] <= data ^ shift_reg[7];
            shift_reg[1] <= shift_reg[0] ^ data ^ shift_reg[7];
            shift_reg[2] <= shift_reg[1] ^ data ^ shift_reg[7];
            shift_reg[3] <= shift_reg[2];
            shift_reg[4] <= shift_reg[3];
            shift_reg[5] <= shift_reg[4];
            shift_reg[6] <= shift_reg[5];
            shift_reg[7] <= shift_reg[6];
            crc8_out     <= shift_reg;
        end
    end
    assign crc_out = crc_valid ? crc8_out[7-cnt_out] : 0;

    

endmodule //crc8