//快时钟域脉冲同步到慢时钟域
module pluse_sync(
	input src_clk,
    input src_rstn,
    input s_pluse,
    input des_clk,
    input des_rstn,
    output des_pluse
);
    //检测脉冲，并将其转换为源时钟域的边沿信号
	reg src_pluse;
	always @(posedge src_clk or negedge src_rstn) begin
        if(!src_rstn) begin
            src_pluse <= 1'b0;
        end else if(s_pluse) begin
            src_pluse <= ~src_pluse;
        end
    end

    //在目标时钟域，对边沿信号进行双边沿检测即可同步脉冲
    reg [1:0] des_r;
    always @(posedge des_clk or negedge des_rstn) begin
        if (!des_rstn) begin
            des_r <= 2'b00;
        end else begin
            des_r <= {des_r[0],src_pluse};
        end
    end

    assign des_pluse = des_r[0] ^ des_r[1];
endmodule