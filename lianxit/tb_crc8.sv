`timescale 1ps/1ps
//  Module: tb_crc8
//
class data_32;
    rand bit data[$];
    string name;
    constraint c {
        /*  solve order constraints  */
        data.size() == 32;
        /*  rand variable constraints  */   
    }
    
    function new(string name = "dinseq");
        this.name = name;
    endfunction

    function void display(string prefix);
        foreach(data[i])
        $display("[%s]%0t %s data[%0d] = %0d", prefix, $realtime, name, i, data[i]);
    endfunction
    //G(x) = x8+x2+x1+1
    function bit crc8()
        
    endfunction 
endclass
module tb_crc8;
    //例化
    logic clk;
    logic rst_n;
    logic data;
    logic data_valid;
    logic crc_start; //CRC开始信号，持续一个clk
    logic crc_out;  //crc 串行输出
    logic crc_valid; //CRC valid

    crc8 dut (
        clk,
        rst_n,
        data,
        data_valid,
        crc_start, //CRC开始信号，持续一个clk
        crc_out,  //crc 串行输出
        crc_valid //CRC valid
    );

    //
    data_32 data1;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end
    
    initial begin
        data1 = new();
        assert (data1.randomize());
        data1.display("data gerenal");
        rst_n <= 0;
        data_valid <= 0;
        crc_start <= 0;
        #100
        rst_n <=1;
        @(posedge clk);
        crc_start <= 1;
        @(posedge clk);
        crc_start <= 0;
        @(posedge clk);
        foreach (data1.data[i]) begin
            data <= data1.data[i];
            data_valid <= 1;
            @(posedge clk);
        end
        data_valid <= 0;
        @(posedge clk);
        @(negedge crc_valid);
        repeat(5) @(posedge clk);
        $stop();
    end

    
endmodule: tb_crc8
