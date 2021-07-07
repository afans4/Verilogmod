/**
检测输入序列中的次小值和次小值个数
**/
module sec_min (
    input clk, //时钟信号
    input rst_n, //复位信号
    input [9:0] din, //10bit无符号数
    input din_vld, //输入数据有效信号
    output [9:0]  dout, //次小值
    output [8:0]  cnt //次小值出现的次数，溢出时重新计数
);
    //reg
    reg [9:0] secmin,min ;
    reg [8:0] cnt_temp;

    //条件
    wire min_c,secmin_c,cnt_ad;
    assign min_c = (din < min);
    assign secmin_c = (din > min) & (din <secmin);
    assign cnt_ad = din == secmin;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            secmin <= 10'b11_1111_1111;
            min <= 10'b11_1111_1111;
            cnt_temp <= 0;
        end else if(din_vld) begin
            if (min_c) begin
                min <= din;
                secmin <= min;
                cnt_temp <= 1;
            end else if(secmin_c) begin
                secmin <= din;
                cnt_temp <= 1;
            end else begin
                cnt_temp <= cnt_ad ? cnt_temp + 1 : cnt_temp;
            end
        end else begin
            min <= min;
            secmin <= secmin;
            cnt_temp <= cnt_temp;
        end       
    end
    //避免初始值输出
    reg [1:0] init_cnt;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            init_cnt <= 0;
        end else begin
            init_cnt <= (init_cnt == 2) ? init_cnt :init_cnt + 1;
        end
    end
    assign dout = (init_cnt >= 2)? secmin : 10'bz;
    assign cnt = cnt_temp;
endmodule //sel_min