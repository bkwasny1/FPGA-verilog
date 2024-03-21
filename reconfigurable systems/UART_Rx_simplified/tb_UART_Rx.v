`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.03.2024 09:27:38
// Design Name: 
// Module Name: tb_UART_Rx
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
module save_file_rx(input [7:0] data, input received);
integer file1;
reg prev_rec = 0;

initial begin
    file1 = $fopen("G:\\Program Files\\semestr6\\Systemy rekonfigurowalne\\lab2\\from_UART.txt", "wb");
    if (file1) 
        $display("Plik zostal otwarty : %0d", file1);
    else
        $display("Plik nie zostal otwarty");
        
    while (1) begin
        #2;
        if (received) begin
            $fwrite(file1, "%c", data);
        end
    end
end

initial begin
    #360;
    $fclose(file1);
    $stop;
end
endmodule


module tb_UART_Rx();

reg clk = 0;
reg rst = 0;
wire send;
wire [7:0] data;
wire [7:0] data_rx;
wire tx;
wire received;

initial begin
    while(1) begin
        #1;
        clk = ~clk;
    end
end

load_file DUT_load (data, send);
save_file_rx DUT_save (data_rx, received);
State_machine DUT_tx (clk, rst, send, data, tx);
UART_Rx DUT_rx (clk, rst, tx, data_rx, received);

endmodule
