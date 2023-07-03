`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.06.2023 09:13:26
// Design Name: 
// Module Name: uart_rx_tb
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


module uart_rx_tb(

    );
   
    reg clk2;
    reg rst;
    wire [7:0]p_data;
   reg data;
    wire valid_data;
   
   reg parity_en,parity_type;
    //assume Tx clock is 25MHz
    //assume Rx clock is 400 MHz
    parameter Tx_period = 40;
    parameter Rx_period = 2.5;
    
    uart_rx_top dut (.clk2(clk2),.valid_data(valid_data),.parity_type(parity_type),.rst(rst),.p_data(p_data),.data(data),.parity_en(parity_en));
    
    
    initial begin
        clk2=0;
    end
    
    
    always begin
        clk2 = ~clk2;     #(Rx_period/2);
    end
    initial begin
        reset();
        testcase1();
        testcase2();
        testcase3();
        $finish;
    end

task reset;
    begin
        rst=1 ; #5;
        rst=0; #5;
        rst=1;
    end

endtask


/*Even parity with parity enable*/
task testcase1;
    begin
        parity_en=1;
        parity_type = 1;            //even parity
        data = 0; #(Tx_period);   //start bit
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 0; #(Tx_period);   //parity bit
        data = 1; #(Tx_period);   //stop bit
    end
endtask
/*odd parity with parity enable*/

task testcase2 ;
    begin
        parity_en=1;
        parity_type = 0;            //even parity
        data = 0; #(Tx_period);   //start bit
        data = 0; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);   //parity bit
        data = 1; #(Tx_period);   //stop bit
    
    end
endtask
/*Even parity with parity enable but with wrong parity bit
   so the valid_data signal should be zero		
*/

task testcase3 ;
    begin
        parity_en=1;
        parity_type = 1;            //even parity
        data = 0; #(Tx_period);   //start bit
        data = 1; #(Tx_period);
        data = 0; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 1; #(Tx_period);
        data = 0; #(Tx_period);   //parity bit
        data = 1; #(Tx_period);   //stop bit
    
    end
endtask

















endmodule
