`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2023 09:38:00
// Design Name: 
// Module Name: uart_tx_top
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


module uart_tx_top(
    input clk,
    input rst,
    input [7:0] data,
    input data_valid,
    input parity_en,
    input parity_type,
    output done,
    output out,
    output serial_data,//
    output busy,//
    output [2:0]current_state//
    );
    
    wire busy,parity;
    wire ser_en,ser_load;//done;
    wire [2:0] mux_sel;
    wire serial_data;
    
    
    uart_tx_fsm dut1(.data_valid(data_valid),.ser_done(done),.clk(clk),.rst(rst),.parity_en(parity_en),.
                     current_state(current_state),.mux_sel(mux_sel),.busy(busy),.ser_en(ser_en),.ser_load(ser_load));
                     
    serializer dut2 (.clk(clk),.rst(rst),.busy(busy),.enable(ser_en),.load(ser_load),.data_in(data) 
                    ,.data_out(serial_data),.done(done));
                    
                    
    parity_calc dut3 (.clk(clk),.rst(rst),.parity_type(parity_type),.parity_en(parity_en),.parity_data(data)
                      ,.busy(busy),.parity(parity));
                      
    mux8x1      dut4 (.sel(mux_sel),.Data(serial_data),.Parity(parity),.out(out));                  
                                 
                     
                     
                     
                     
                     
                     
                     
                     
                     
                
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
