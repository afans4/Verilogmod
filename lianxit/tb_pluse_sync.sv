`timescale 1ps/1ps
//  Module: tb_pluse_sync
//
module tb_pluse_sync;
    
    //模块例化
    logic src_clk  ;
    logic src_rstn ;
    logic s_pluse  ;
    logic des_clk  ;
    logic des_rstn ;
    logic des_pluse;
    pluse_sync dut(
        .src_clk    (src_clk),
        .src_rstn   (src_rstn),
        .s_pluse    (s_pluse),
        .des_clk    (des_clk),
        .des_rstn   (des_rstn),
        .des_pluse  (des_pluse)
    );

    //clk general
    initial begin
        src_clk = 0;
        forever begin
            #15 src_clk = ~src_clk; 
        end
    end
    initial begin
        des_clk = 0;
        forever begin
            #10 des_clk = ~des_clk;
        end
    end
    //复位信号统一
    assign des_rstn = src_rstn;
    //
    
    initial begin
        src_rstn = 0;
        s_pluse = 0;
        #80
        src_rstn = 1;
        #20
        s_pluse = 1;
        #40
        s_pluse = 0;
        #80
        s_pluse = 1;
        #40
        s_pluse = 0;
        #200
        $stop();
    end
endmodule: tb_pluse_sync
