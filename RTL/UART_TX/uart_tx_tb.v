`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2023 12:52:48
// Design Name: 
// Module Name: uart_tx_tb
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


module uart_tx_tb(
    
    );
    reg clk1;
    reg rst;
    reg [7:0] data;
    reg data_valid;
    reg parity_en;
    reg parity_type;
    wire out;
    wire done;

    parameter even =1,odd=0;
	uart_tx_top dut (.clk1(clk1),.rst(rst),.data(data),.data_valid(data_valid),.parity_en(parity_en)
                     ,.done(done),.parity_type(parity_type),.out(out));
                        
     initial begin
        rst=1; #5;
		rst=0; #5;
        rst=1;
        clk1=0;
           
     end                   
    
    always begin
        clk1 = ~clk1; #5;
    end
    
    
    always begin
	/*Test case 1 with parity enabled*/
			parity_en=1;  
			parity_type=0;    
			data_valid=1;       #10;
			data=8'b01111101;   #100;
            data_valid=0;       #100;
	/*Test case 2 with parity disabled*/		
			parity_en=0;  
			data_valid=1;       #10;
			data=8'b11111111;   #100;
            data_valid=0;       #100;
        $finish;
    end
    
    
  
    
endmodule
