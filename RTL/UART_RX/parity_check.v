`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2023 10:34:27
// Design Name: 
// Module Name: parity_check
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


module parity_check(
    input parity_chk_en,
    input clk2,
    input parity_type,
    input rst,
    input sampled_data,
    input [7:0]p_data, // data from deserializer
    output  reg par_err
    );
    
    parameter even =1 , odd=0;
    reg [7:0] data;
    always @(posedge clk2 or negedge rst) begin
        if(!rst) begin
            par_err<=0;
            data<=0;
        end
        else begin
            if(parity_chk_en) begin
                data <= p_data;
                if(parity_type == even) begin
                    par_err <= (^data == sampled_data)?'b0:'b1;
                end
                else begin
                    par_err <= (~(^data) == sampled_data)?'b0:'b1;
                end
            end
        end
    end
    
endmodule
