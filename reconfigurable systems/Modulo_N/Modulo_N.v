`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2024 21:10:54
// Design Name: 
// Module Name: Modulo_N
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


module Modulo_N # (parameter N = 2, parameter WIDTH = $clog2(N))
(
    input clk, ce, rst,
    output [WIDTH - 1 : 0]y
    );
    
reg [WIDTH - 1 : 0] val = 0;

always @(posedge clk) begin
    if (rst)
        val <= 0;
    else
        if (ce)
            if (val == N - 1)
                val = 0;
            else
                val <= val + 1;
        else 
            val <= val;
end

assign y = val;
endmodule
