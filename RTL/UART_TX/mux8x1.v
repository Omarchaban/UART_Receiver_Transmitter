`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 12:01:03
// Design Name: 
// Module Name: mux8x1
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


module mux8x1(
    input[2:0] sel,
    input Data,
    input Parity,
    output reg out
    );
    
    parameter idle = 3'b000, start = 3'b001, data = 3'b010, parity = 3'b011, stop = 3'b100;
    always@(*) begin
        out=1;
        case(sel)
            idle:   out=1;
            start:  out=0;
            data :  out = Data;
            parity: out = Parity;
            stop:   out =1;
        
        endcase
    end
    
    
    
    
    
    
    
    
    
    
    
endmodule
