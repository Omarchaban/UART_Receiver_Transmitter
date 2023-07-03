`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2023 12:37:13
// Design Name: 
// Module Name: stop_chk
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


module stop_chk(
    input stop_chk_en,
    input data_in,
    input clk2,
    input rst,
    output reg stop_err
    );
    
    
    always @(posedge clk2 or negedge rst) begin
        if(!rst) begin
            stop_err <=0;
        end
        else begin
            if(stop_chk_en) begin
                if(data_in) begin
                    stop_err <=0;
                end
                else begin
                    stop_err <=1;
                end
            end
            else begin
              stop_err <= stop_err;
            end
        end
    end
    
    
    
    
    
    
    
    
endmodule
