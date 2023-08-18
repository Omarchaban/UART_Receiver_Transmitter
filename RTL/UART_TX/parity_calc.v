`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2023 09:27:28
// Design Name: 
// Module Name: parity_calc
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


module parity_calc(
    input [7:0] parity_data,
    input parity_type,
    input clk1,
    input rst,
    input busy,
    input parity_en,
    output reg parity
    
    );
    parameter even = 1,odd= 0;
    
    
    always@(posedge clk1 or negedge rst) begin
        if(!rst) begin
            parity=0;
        end
        else begin
            if(parity_en) begin
                if(parity_type == even) begin
                    parity = ^ parity_data;
                end
                else begin
                    parity = ~^ parity_data;
                end
            end
        end
    end    
    
endmodule
