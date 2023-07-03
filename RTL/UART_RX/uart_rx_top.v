`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.06.2023 11:07:39
// Design Name: 
// Module Name: uart_rx_top
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


module uart_rx_top(
    input clk2,
    input rst,
    input data,
    input parity_en,
    input parity_type,
    output [7:0]p_data,
    output valid_data  
    );
    
    wire des_en;
    wire sample_en;
    wire sampled_data;
    wire done;
    wire [4:0] edge_cnt;
    wire stop_err,start_err,parity_err;
    wire parity_chk_en,stop_chk_en,start_chk_en;
    wire edge_cnt_en;
    wire [3:0] bit_cnt;
    
    stop_chk dut5(.stop_chk_en(stop_chk_en),.clk2(clk2),.rst(rst),.data_in(sampled_data),.stop_err(stop_err));
    start_chk dut6(.start_chk_en(start_chk_en),.clk2(clk2),.rst(rst),.data_in(sampled_data),.start_err(start_err));
    parity_check dut7 (.clk(clk),.p_data(p_data),.parity_chk_en(parity_chk_en),.parity_type(parity_type)
                        ,.sampled_data(sampled_data),.rst(rst),.par_err(parity_err));
    
    
    sampler dut2 (.data(data),.sample_enable(sample_en),.sampled_data(sampled_data));
    
    
    deserializer dut1 (.clk2(clk2),.bit_cnt(bit_cnt),.rst(rst),.des_en(des_en),.sampled_data(sampled_data),.edge_cnt(edge_cnt)
                        ,.done(done),.p_data(p_data));
                        
    
    
    edge_counter dut3 (.clk2(clk2),.rst(rst),.parity_en(parity_en),.enable(edge_cnt_en),.bit_cnt(bit_cnt),.edge_cnt(edge_cnt));
    
    
    uart_rx_fsm dut4(.clk2(clk2),.stop_chk_en(stop_chk_en),.start_chk_en(start_chk_en),.bit_cnt(bit_cnt),.rst(rst)
                    ,.data_in(data),.valid_data(valid_data),.parity_en(parity_en),.edge_cnt(edge_cnt),.done(done)
                    ,.sample_en(sample_en),.edge_cnt_en(edge_cnt_en),.deserializer_en(des_en),.parity_chk_en(parity_chk_en)
                    ,.parity_err(parity_err),.stop_err(stop_err),.start_err(start_err));
    
    
    
    
endmodule
