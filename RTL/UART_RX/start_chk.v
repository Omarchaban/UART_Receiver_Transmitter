`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 12:40:54
// Design Name: 
// Module Name: start_chk
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


module start_chk(
    input clk2,
    input rst,
    input data_in,
    input start_chk_en,
    output reg start_err
    );
    
    
      
    always @(posedge clk2 or negedge rst) begin
        if(!rst) begin
            start_err <=0;
        end
        else begin
            if(start_chk_en) begin
              
                    start_err <=data_in;
                end
                else begin
                    start_err <= start_err;
                end
            end
        end
    
endmodule
