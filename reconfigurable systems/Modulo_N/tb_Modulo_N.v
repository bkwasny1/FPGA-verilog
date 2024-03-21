`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2024 21:21:58
// Design Name: 
// Module Name: tb_Modulo_N
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_Modulo_N();
localparam N = 5;
localparam WIDTH = $clog2(N);

reg clk = 0;
reg ce = 1;
reg rst = 0;
wire [WIDTH - 1 : 0] y;

Modulo_N #(.N(N)) DUT (clk, ce, rst, y);

initial begin
    while (1) begin
        #1;
        clk = ~clk;
    end
end

initial begin
    #8;
    ce = 0;
    #8;
    ce = 1;
    #8;
    rst = 1;
    #8;
    rst = 0;
end
endmodule
