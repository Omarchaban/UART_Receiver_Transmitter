`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2023 11:14:33
// Design Name: 
// Module Name: edge_counter
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


module edge_counter
     # (parameter prescaler = 16)
    (
    input serial_data,
    input sample_en,
    input clk2,
    input rst,
    input parity_en,
    input enable,
    output reg [3:0] bit_cnt,
    output reg sampled_data,
    output reg [4:0] edge_cnt,
    output start
    );
    reg start;
   always @(posedge clk2 or negedge rst) begin
        if(!rst) begin
            edge_cnt<=0;
            bit_cnt <=0;
            start <=0;
        end
        else begin
            if(enable) begin
                
                if(((edge_cnt == (prescaler >>1)-1)) && (start ==0) ) begin
                    start <=1;
                    bit_cnt <= bit_cnt+1;
                end
                else if ((edge_cnt == prescaler-1)  && (start == 1)) begin
                    bit_cnt <= bit_cnt+1;
                end
            end
            else
                edge_cnt<=0;
            end
        end
        
    
   always @(posedge clk2 ) begin
        if(enable) begin
            edge_cnt<=edge_cnt +1;
            if(((edge_cnt == (prescaler >>1)-1)) && (start ==0) ) begin
                edge_cnt<=0;
            end
            if ((edge_cnt == prescaler-1)  && (start == 1)) begin
                 edge_cnt<=0;
            end
        end
   end
   /*Restart the whole process after receiveing the stop bit*/
   always @(posedge clk2 ) begin
        if(bit_cnt =='hb || (bit_cnt =='ha && !parity_en)) begin
            start <=0;
            bit_cnt<=0;
        end
   end
  
    
endmodule
