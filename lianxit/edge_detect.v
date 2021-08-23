//编译选项
`define nsy3
module delay_clap(
    input       clk1,  //异步慢时钟
    input       sig1,  //异步信号

    input       rstn,  //复位信号
    input       clk2,  //目的快时钟域市政
    output      sig2_pos,
    output      sig2_neg,
    output      sig2_pone); 
    `ifdef nsy3
	///3级同步处理
    reg [2:0]    sig2_r ;   //3级缓存，前两级用于同步，后两节用于边沿检测
    always @(posedge clk2 or negedge rstn) begin
        if (!rstn) begin
            sig2_r  <= 3'b0 ;
        end else begin
            sig2_r  <= {sig2_r[1:0], sig1} ;  //缓存
        end
    end

    assign sig2_pos = sig2_r[1] && !sig2_r[2] ; //上升沿检测
    assign sig2_neg = !sig2_r[1] && sig2_r[2]; //下降沿检测
    assign sig2_pone = sig2_r[1] ^ sig2_r[2]; //双边沿检测
    `else
    //两级同步处理
    reg [1:0]    sig2_r ;   //3级缓存，前两级用于同步，后两节用于边沿检测
    always @(posedge clk2 or negedge rstn) begin
        if (!rstn) begin
            sig2_r  <= 3'b0 ;
        end else begin
            sig2_r  <= {sig2_r[0], sig1} ;  //缓存
        end
    end
    
    assign sig2_pos = sig2_r[0] && !sig2_r[1] ; //上升沿检测
    assign sig2_neg = !sig2_r[0] && sig2_r[1]; //下降沿检测
    assign sig2_pone = sig2_r[0] ^ sig2_r[1]; //双边沿检测
    `endif
endmodule