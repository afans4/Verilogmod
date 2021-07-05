`timescale 1ps/1ps
//  Module: tb_vend_machine
//
module tb_vend_machine();
    //input
    logic clk;
    logic rst_n;
    logic coin_5;
    logic coin_10;
    logic drink_5;
    logic drink_10;
    //output
    logic [1:0] drinko;
    logic chang; 

    vend_machine dut(
        .clk(clk),
        .rst_n(rst_n),
        .coin_5(coin_5),
        .coin_10(coin_10),
        .drink_5(drink_5),
        .drink_10(drink_10),
        .drinko(drinko),
        .chang(chang));

    //clk gener
    initial begin
        clk  = 0;
        forever #10 clk = ~clk;
    end
    
    //
    initial begin
        rst_n = 0;
        coin_5 = 0;
        coin_10 = 0;
        drink_5 = 0;
        drink_10 = 0;

        #100
        rst_n = 1;
        #20
        drink_5 = 1;
        #60 drink_5 = 0;
        coin_10 = 1;
        #40 coin_10 = 0;
        #100;

        #20
        drink_10 = 1;
        #60 drink_10 = 0;
        coin_5 = 1;
        #40 coin_5 = 0;
        #20 coin_10 = 1;
        #40 coin_10 = 0;
        #100;

        $stop();
    end
endmodule: tb_vend_machine
