`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.06.2023 09:55:05
// Design Name: 
// Module Name: UART_top_tb
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


module UART_top_tb(

    );
     reg parity_type;
    reg parity_en;
    reg clk1; //tx clock
    reg clk2; //rx clock
    reg rst;
        reg [7:0] data;
    reg data_valid;
    wire [7:0] p_data;
    wire valid_data;
    wire stop_err,parity_err,sampled_data;//
    
    UART_top dut (.parity_type(parity_type),.parity_en(parity_en),.clk1(clk1),.clk2(clk2)
                 ,.stop_err(stop_err),.sampled_data(sampled_data) ,.parity_err(parity_err) ,.data(data),.rst(rst),.data_valid(data_valid),.p_data(p_data),.valid_data(valid_data));
                    
    initial begin
    clk2=0;
        clk1=0;
        
        rst=1; #5;
        rst=0; #5;
        rst=1; #5;
        
    end               
    always begin
        clk1 = ~clk1 ; #20;
        
    end                 
   
    always begin
        clk2 = ~clk2;  #1.25;
    
    end
    initial begin
    data_valid =1;
    parity_en=1;
    parity_type =1;
    
        data = 8'b11111111; #50;
    data_valid=0;
    #500;
         data_valid =1;
    parity_en=0;
    parity_type =1;
    
        data = 8'b01111111; #50;
    data_valid=0;
    #500;   

    $finish;
    
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
endmodule
