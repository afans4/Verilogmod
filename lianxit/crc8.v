module crc4 (
    input  clk,
    input  rst_n,
    input  data_in,
    input  data_valid,
    input  crc_start, //CRC开始信号，持续一个clk
    output wire crc_out,  //crc 串行输出
    output reg crc_valid //CRC valid
);

    //G(D)=D8+D2+D+1
    //crc_reg
    reg [7:0] crc_reg_q;
    wire [7:0] crc_reg_d;
    assign crc_reg_d[0] = crc_reg_q[7] ^ data_in;
    assign crc_reg_d[1] = crc_reg_q[7] ^ data_in ^ crc_reg_q[0];
    assign crc_reg_d[2] = crc_reg_q[7] ^ data_in ^ crc_reg_q[1];
    assign crc_reg_d[3] = crc_reg_q[2];
    assign crc_reg_d[4] = crc_reg_q[3];
    assign crc_reg_d[5] = crc_reg_q[4];
    assign crc_reg_d[6] = crc_reg_q[5];
    assign crc_reg_d[7] = crc_reg_q[6];
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            crc_reg_q <= 8'hff;
        end else if(data_valid) begin
            crc_reg_q <= crc_reg_d;
        end else begin
            crc_reg_q <= crc_reg_q;
        end
    end

    reg [2:0] count;
    reg crc_out_r;
    always @ (posedge clk or negedge rst_n)
    begin
        if(rst_n)begin
           crc_out_r <= 0;
            count<= 0;
        end
        else begin
           if(data_valid) begin
               crc_out_r <= data_in;
               crc_valid <= 1'b0;
            end
            else if(crc_start)begin
               count <= count + 1'b1;
               crc_out_r <= crc_reg_q [7-count];
               crc_valid <= 1'b1;
            end
            else begin
               crc_valid <= 1'b0;
            end
        end
    end
    assign crc_out = crc_out_r;
    

endmodule //crc8