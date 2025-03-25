`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2025 15:00:27
// Design Name: 
// Module Name: wr_ptr_handlr
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


module wr_ptr_handlr #(parameter ADDR_SIZE =4)(
                        input winc,wclk,wrst_n,
                        input [ADDR_SIZE :0] wq2_rptr,
                        output [ADDR_SIZE-1:0] waddr,
                        output reg [ADDR_SIZE :0] wptr,
                        output reg wfull);
                        
reg [ADDR_SIZE:0] wbin;
wire [ADDR_SIZE:0] wgray_next,wbin_next;
wire wfull_val;

always@(posedge wclk or negedge wrst_n) begin 
if (!wrst_n)
    {wbin,wptr} <=0;
else 
    {wbin,wptr} <= {wbin_next,wgray_next};
end 

assign waddr = wbin[ADDR_SIZE-1:0];
assign wbin_next = wbin + (winc & ~wfull);
assign wgray_next = (wbin_next>>1)^wbin_next;

assign wfull_val = (wgray_next=={~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1], wq2_rptr[ADDR_SIZE-2:0]});

always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n)            // Reset the full flag
        wfull <= 1'b0;
    else 
        wfull <= wfull_val; // Update the full flag
end

endmodule
