`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2024 10:52:50
// Design Name: 
// Module Name: tb_State_machine
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
module load_file(output [7:0] data, output send);

integer file;
reg [7:0]file_data;
reg [7:0]i;
reg send_flag = 0;

initial begin
    file = $fopen("G:\\Program Files\\semestr6\\Systemy rekonfigurowalne\\lab2\\note.txt","rb");
    
    if (file) 
        $display("Plik zostal otwarty : %0d", file);
    else
        $display("Plik nie zostal otwarty");
     #2;
     send_flag = 1;
     while (! $feof(file)) begin
        file_data = $fgetc(file);
        #2;
        send_flag = 0;
        #20;
        send_flag = 1;
     end
    $fclose(file);
    send_flag = 0;
end

assign data = file_data;
assign send = send_flag;
endmodule


module save_file(input c);
integer file;
reg [7:0] i;
wire data = c;

initial begin
    file = $fopen("G:\\Program Files\\semestr6\\Systemy rekonfigurowalne\\lab2\\note_save.txt", "wb");
    if (file) 
        $display("Plik zostal otwarty : %0d", file);
    else
        $display("Plik nie zostal otwarty");
    #5;
    for(i=0; i < 11 * 16 + 1; i = i + 1) begin
        $fwrite(file, "%d", data);
        #2;
    end
    
$fclose(file);
end
endmodule


module tb_State_machine();

reg clk = 0;
reg rst = 0;
wire send;
wire [7:0] data;
wire tx;

initial begin
    while(1) begin
        #1;
        clk = ~clk;
    end
end

load_file DUT_load (data, send);
save_file DUT_save (tx);
State_machine DUT (clk, rst, send, data, tx);

endmodule
