`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2023 09:35:33
// Design Name: 
// Module Name: UART_top
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


module UART_top(
    input parity_type,
    input parity_en,
    input clk1, //tx clock
    input clk2, //rx clock
    input rst,
        input [7:0] data,
    input data_valid,
    output [7:0] p_data,
    output valid_data,
    output sampled_data,//
    output parity_err,//
    output stop_err//
    );
    
    
    wire out;
    
    
    
    uart_tx_top dut1 (.clk1(clk1),.rst(rst),.data(data),.data_valid(data_valid),.parity_en(parity_en),.parity_type(parity_type)
                        ,.out(out)  );
                        
    uart_rx_top dut2 (.clk2(clk2),.parity_err(parity_err),.sampled_data(sampled_data),.stop_err(stop_err),.rst(rst),.data(out),.parity_en(parity_en),.parity_type(parity_type),.p_data(p_data)
                      ,.valid_data(valid_data));
    
    
    
    
    
    
    
    
    
    
endmodule
