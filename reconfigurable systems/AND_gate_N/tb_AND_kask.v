`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.03.2024 09:23:43
// Design Name: 
// Module Name: tb_AND_kask
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


module tb_AND_kask();
localparam LENGTH = 10;

reg [LENGTH - 1 : 0] x = 1000;
reg clk = 0;
wire y;

AND_kask #(.LENGTH(LENGTH)) DUT (.x(x), .y(y));

initial begin
    while(1) begin
        #1;
        clk = ~clk;
    end
end

always @(posedge clk) begin
    x = x + 1;
end
endmodule
