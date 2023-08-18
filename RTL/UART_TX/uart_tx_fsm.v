`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2023 09:48:19
// Design Name: 
// Module Name: uart_tx_fsm
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


module uart_tx_fsm(
    input data_valid,
    input ser_done,
    input clk1,
    input rst,
    input parity_en,
    output reg [2:0] mux_sel,
    output reg ser_en,
    output reg busy
    );
 
 reg [2:0] next_state,current_state;
 
 parameter idle = 3'b000, start = 3'b001, data = 3'b010, parity = 3'b011, stop = 3'b100;
 
 
    always @(posedge clk1 or negedge rst) begin
    if(!rst ) begin
        current_state <= idle;
    
    end
    else begin
        current_state <= next_state;
    end
 
 end    
    
 always @(*) begin 
    //next_state = idle;
    case(current_state)
       idle: 
            
            if(data_valid) begin
                next_state = start;
                   
            end
            else begin
                
                next_state = idle;
            end
          
       start:   
             next_state = data;
       data:
             
             if(ser_done)
                 if(parity_en) begin
                    next_state = parity;
                 end
                 else begin
                    next_state = stop;
                 end
             else begin
                next_state = data;
             end
             
       parity:
             next_state= stop;
       stop:
             next_state =idle;
    
    
    
     default: next_state =idle;
    endcase
 
 
 end
 always @(*) begin
    case(current_state)
        idle:
            begin
              
                    mux_sel=3'b000;
                    busy=0;
             end   
        start: 
            begin
                busy=1;
                mux_sel=3'b001;
                ser_en=1;
            end
        data:
            begin
               busy=1;
               mux_sel=3'b010;
               if(ser_done) begin
                    ser_en=0;
                    
               end
               else begin
                    ser_en=1;
               end
            end
        parity:
            begin
                mux_sel=3'b011;
                busy=1;
            end
        stop:
            begin
                mux_sel=3'b100;
                busy=1;
            end
        default:mux_sel=0;
    
    
    
    
    endcase
 
 
 end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
