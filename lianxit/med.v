//-----------------------------------------------------------------
//Copyright (c) 2014-2020 All rights reserved
//Author  : 383423151@qq.com
//File    : med
//Create  : 2021-08-12
//Revise  : 2021-
//Editor  : Vscode,tab size (4)
//Funciton:
//
//------------------------------------------------------------------
module med(
    input [2:0] data0,
    input [2:0] data1,
    input [2:0] data2,
    output [2:0] data_med
);
    //wire com_01,com_02,com_12;
    assign com_01 = data0 < data1;
    assign com_02 = data0 < data2;
    assign com_12 = data1 < data2;
    reg [2:0] data_med_r;
    always @ (*) begin
        case ({com_01,com_02,com_12})
            3'd3,3'd4: data_med_r = data0;
            3'd0,3'd7: data_med_r = data1;
            3'd1,3'd6: data_med_r = data2;
            default: data_med_r = data0;
        endcase
    end
    assign data_med = data_med_r;
endmodule//med