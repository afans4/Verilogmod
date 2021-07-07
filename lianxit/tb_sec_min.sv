//  Module: tb_sec_min
//
`timescale 1ps/1ps

class My_din;
    rand logic [9:0] data[$];
    bit [7:0] cnt;
    logic [9:0] min,secmin;
    string name;
    constraint c {
        data.size() inside {[50:60]};
        foreach (data[i]) 
            data[i] inside {[0:50]};
        
        
    };
    
    function new(string name = "dinseq");
        this.name = name;
    endfunction

    function void display(string prefix);
        foreach(data[i])
        $display("[%s]%0t %s data[%0d] = %0d", prefix, $realtime, name, i, data[i]);
    endfunction
endclass

module tb_sec_min;
    
    My_din pac1;//类指针的声明要在initial外
    logic clk; //时钟信号
    logic rst_n; //复位信号
    logic [9:0] din; //10bit无符号数
    logic din_vld; //输入数据有效信号
    logic [9:0]  dout; //次小值
    logic [8:0]  cnt;//次小值出现的次数，溢出时重新计数


    sec_min dut(
        .clk(clk), //时钟信号
        .rst_n(rst_n), //复位信号
        .din(din), //10bit无符号数
        .din_vld(din_vld), //输入数据有效信号
        .dout(dout), //次小值
        .cnt(cnt) //次小值出现的次数，溢出时重新计数
    );

    initial begin
        clk  = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst_n = 0;
        din_vld = 0;
        
        pac1 = new("pac1");
        assert (pac1.randomize());
        pac1.display("data gerenal");
        #100
        rst_n = 1;
        foreach (pac1.data[i]) begin
            din <= pac1.data[i];
            din_vld <= 1;
            @(posedge clk);
        end
        din_vld <= 0;
        @(posedge clk);
        #100

        assert (pac1.randomize());
        pac1.display("seq2");
        foreach (pac1.data[i]) begin
            din <= pac1.data[i];
            din_vld <= 1;
            @(posedge clk);
        end
        din_vld <= 0;
        @(posedge clk);
        #100
        $stop();
    end


endmodule: tb_sec_min
