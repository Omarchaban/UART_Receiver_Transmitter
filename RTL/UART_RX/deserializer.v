`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2023 08:29:09
// Design Name: 
// Module Name: deserializer
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


module deserializer
   # (parameter prescaler = 16)
    (
    input clk2,
    input rst,
    input des_en,
    input sampled_data,
    input [4:0] edge_cnt,
    input [3:0] bit_cnt,
    output reg done,
   
    output  reg [7:0]  p_data
    );
    reg [7:0] temp_data;
  always @(posedge clk2 or negedge rst) begin
    if(!rst) begin
        temp_data<=0;
    end
    else begin
        if(des_en && edge_cnt==(prescaler-1) &&bit_cnt <= 9) begin
            temp_data <= {sampled_data,temp_data[7:1]};
        end
    end
  end
 always @(*) begin
    if(done) begin
        p_data = temp_data;
    end
    else begin
        p_data = p_data;
    end
 end
 
  always @(posedge clk2 or negedge rst) begin
    if(!rst) begin
        done<=0;
    end
    else begin
        if(bit_cnt >= 9) begin
            done<=1;
        end
        else begin
            done<=0;
        end
    end
  end
   
    
endmodule
