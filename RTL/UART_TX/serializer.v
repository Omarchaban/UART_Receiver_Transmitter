`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 09:00:32
// Design Name: 
// Module Name: serializer
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

module serializer(input wire [7:0] data_in,
                  input wire enable,
                  input wire busy,
                  input wire clk1,
                  input wire rst,
                 
                  output  done,
                  output reg data_out);

reg [7:0] shift_reg;
reg [3:0] counter; 
 
  always@(posedge clk1 or negedge rst) begin
    if(!rst) begin
        shift_reg=0;
    end
    else begin
        if( (!busy)) begin
            shift_reg <= data_in;
        end
         if( enable ) begin
            shift_reg <= shift_reg >>1;
        end
    end    
end

// Counter sequential logic
  always@(posedge clk1 or negedge rst) begin
    if(!rst) begin
        counter<=0;
    end
    else begin
        if(enable) begin
            counter <= counter+1;
        end
        else begin 
            counter <= 0;
        end
    end    
end

  always@(posedge clk1 or negedge rst) begin
    if(!rst) begin
        data_out<=0;
    end
    else begin
        if(enable) begin
            data_out <= shift_reg[0];
        end
        else begin 
            data_out <= 0;
        end
    end    
end
assign done = (counter == 8)? 1:0;
//assign data_out = shift_reg[0];
endmodule










