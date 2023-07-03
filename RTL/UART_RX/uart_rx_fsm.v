`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2023 09:26:12
// Design Name: 
// Module Name: uart_rx_fsm
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


module uart_rx_fsm #(parameter prescaler = 16)
    (
    input clk2,
    input rst,
    input start_err,
    input stop_err,
    input parity_err,
    input data_in,
    input parity_en,
    input [4:0] edge_cnt,
    input [3:0] bit_cnt,
    input done,
    output reg sample_en,
    output reg parity_chk_en,
    output reg start_chk_en,
    output reg stop_chk_en,
    output reg edge_cnt_en,
    output reg deserializer_en,
    output   valid_data
    );
    
    parameter IDLE = 0, START =1, DATA =2 , PARITY =3 , STOP =4;
    reg [2:0] current_state,next_state;
    
    always @(posedge clk2 or negedge rst) begin
        if(!rst) begin
            current_state <= IDLE;
        end
        else begin
            current_state <= next_state;
        end
    end
    /////////////////////////////////////////////////
    always @(*) begin
        case(current_state)
        IDLE:begin
            
            if(!data_in && bit_cnt == 0) begin
                next_state = START;
            end
          
            else begin
                next_state = IDLE;
            end
            
        end
        START:begin
            if(bit_cnt == 1 && !start_err) begin
            
                next_state = DATA;
            end
            else if (start_err)begin
                next_state = IDLE;
            end
            else begin
                next_state =START;
            end
        end
        
        DATA: begin
            
            if( done && bit_cnt ==9) begin
                if(parity_en) begin
                    next_state = PARITY;
                end
                else begin
                    next_state = STOP;
                end
            end
            else begin
                next_state = DATA;
            end
        
        end
        PARITY: begin
            if(bit_cnt == 'ha )
                next_state =STOP;
            else begin
                next_state = PARITY;
            end
        end
        STOP: begin
            if(!parity_en && bit_cnt == 'ha) begin
                next_state = IDLE;
            end
            else begin
               if(bit_cnt == 'hb || stop_err) begin
                    next_state = IDLE;
                end
                else begin 
                    next_state = STOP;
                end
            end    
        end
        default: next_state = IDLE;
        endcase
    end
    //////////////////////////////////////////////////////////////
    
    always @(*) begin
        case (current_state) 
            IDLE: begin
                sample_en=0;
                edge_cnt_en  =0;
                stop_chk_en=0;
                if(!data_in ) begin
                    edge_cnt_en = 1;
                end
            end
            START: begin
                sample_en=0;
                start_chk_en =0;
                if(edge_cnt == (prescaler >>1)) begin
                    start_chk_en =1;
                    sample_en =1;
                end
            end
            DATA: begin
                start_chk_en=0;
                deserializer_en =0;
                sample_en =0;
                if(!done  && edge_cnt == prescaler-1) begin
                    sample_en =1;
                    deserializer_en =1;
                end
                else if(done) begin
                    deserializer_en=0;
                end
            end
            PARITY : begin
                  parity_chk_en =0;
                  sample_en =0;
                  if(edge_cnt == prescaler-1) begin
                    parity_chk_en =1;
                    sample_en =1;
                  end
            end
                
            STOP: begin
                parity_chk_en =0;
                stop_chk_en=0;
                sample_en=0;
                if(edge_cnt == prescaler-1) begin
                    stop_chk_en =1;
                    sample_en=1;
                end
            end
        endcase
    
    end
        assign valid_data = (!stop_err && !parity_err)? 1:0;


endmodule
