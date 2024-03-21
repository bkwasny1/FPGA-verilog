`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2024 10:10:29
// Design Name: 
// Module Name: tb_Delay_line
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


module tb_Delay_line();
localparam N = 5;
localparam DELAY = 4;

reg clk = 0;
reg ce = 1;
reg [N - 1:0] idata = 4;
wire [N - 1:0] y;

initial begin
    while(1) begin
        #1;
        clk = ~clk;
    end
end

Delay_line #(.N(N), .DELAY(DELAY)) DUT (idata, clk, ce, y);

endmodule
