`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2024 10:07:38
// Design Name: 
// Module Name: Delay_line
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


module register #(parameter N = 5)
(
    input clk,
    input ce,
    input [N - 1:0]d,
    output [N - 1:0]q
);

reg [N - 1:0] val = 0;

always @(posedge clk) begin
    if(ce) val<=d;
    else val<=val;
end

assign q = val;
endmodule


module Delay_line #(parameter N = 5, DELAY = 4)
(input [N - 1:0]idata, input clk, ce, output [N - 1:0] odata);

wire [N-1:0] tdata [DELAY - 1 : 0];

genvar i;
generate
    if (DELAY == 0) begin
        assign odata = idata;
    end
    else if (DELAY > 0) begin
        register  #(.N(N)) reg_i(clk, ce, idata, tdata[0]);
        
        for(i = 0; i < DELAY - 1; i = i + 1) begin
            register  #(.N(N)) reg_i(clk, ce, tdata[i], tdata[i+1]);
        end
        assign odata = tdata[DELAY - 1];
    end
endgenerate

endmodule

