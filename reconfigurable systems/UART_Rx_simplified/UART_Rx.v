`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 07:38:25
// Design Name: 
// Module Name: UART_Rx
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


module UART_Rx(input clk, rst, rxd, output [7:0] data, output received);
localparam BIT_NUMBER = 8;
localparam WIDTH = $clog2(BIT_NUMBER);
localparam IDLE = 0 , DATA = 1, STOP = 2;

reg [WIDTH : 0] bit_counter = 0;
reg [1:0] state = IDLE;
reg prev_rxd = 0;
reg [BIT_NUMBER - 1 : 0] data_reg;
reg rec;

always @ (posedge clk) begin

    if (rst)
        state <= IDLE;
    else begin
        case(state)
            IDLE: begin
                if (rxd != prev_rxd && rxd == 1) begin
                    state = DATA;
                end
            end
            
            DATA: begin
                data_reg[bit_counter] = rxd;
                bit_counter = bit_counter + 1;
                if (bit_counter == 8) begin
                    bit_counter = 0;
                    state = STOP;
                    rec = 1;
                end
            end
            
            STOP: begin
                state = IDLE;
                rec = 0;
            end
            
            default:
                data_reg = 0;
        endcase
    end
    prev_rxd = rxd;
    
end

assign received = rec;
assign data = data_reg;

endmodule
