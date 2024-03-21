`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2024 10:31:12
// Design Name: 
// Module Name: State_machine
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


module State_machine(input clk, rst, send, input [7:0] data, output tx);
localparam BIT_NUMBER = 8;
localparam WIDTH = $clog2(BIT_NUMBER);
localparam IDLE = 0, START = 1, DATA = 2, STOP = 3;

reg [WIDTH : 0] bit_counter = 0;
reg [1:0] state = IDLE;
reg prev_send = 0;
reg tx_bit = 0;
reg [BIT_NUMBER - 1 : 0] data_reg;

always @ (posedge clk) begin

    if (rst)
        state <= IDLE;
    else begin
        case(state)
            IDLE: begin
                if (send != prev_send && send == 1) begin
                    data_reg = data;
                    state = START;
                end
            end
            
            START: begin
                tx_bit = 1;
                state = DATA;
            end
            
            DATA: begin
                tx_bit = data_reg[bit_counter];
                bit_counter = bit_counter + 1;
                if (bit_counter == 8) begin
                    bit_counter = 0;
                    state = STOP;
                end
            end
            
            STOP: begin
                tx_bit = 0;
                state = IDLE;
            end
            
        endcase
    end
    prev_send = send;
    
end
assign tx = tx_bit;
endmodule
