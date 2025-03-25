`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 14:40:51
// Design Name: 
// Module Name: two_ff_sync
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


module two_ff_sync #(parameter SIZE =4)(input [SIZE -1:0] din,
                    input clk,rst_n,
                    output reg [SIZE-1:0] q2);

reg [SIZE-1:0] q1;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        {q2,q1} <= 0;
    else
        {q2,q1}<={q1,din};
end 
endmodule
