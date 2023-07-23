`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.07.2023 19:45:43
// Design Name: 
// Module Name: VendingMachine_tb
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

module VendingMachine_tb();

// Inputs
reg clk;
reg rst;
reg [6:0] coin;
reg [2:0] product_code;
reg online_payment;
reg start;
reg cancel;

// Outputs
wire [3:0] state;
wire dispense_product;
wire [6:0] return_change;
wire [6:0] product_price;

// Instantiate the VendingMachine module
VendingMachine dut(
    .clk(clk),
    .rst(rst),
    .total_coin_value(coin),
    .product_code(product_code),
    .online_payment(online_payment),
    .start(start),
    .cancel(cancel),

    .state(state),
    .dispense_product(dispense_product),
    .return_change(return_change),
    .product_price(product_price)
);

// Clock generation
localparam T=10;  // Clock Time Period
always begin
    clk = 1'b0;
    #(T/2);
    clk = 1'b1;
    #(T/2);
end

initial begin
    rst = 1'b1;
    cancel = 1'b0; // Ensure cancel is initially deasserted
    start = 1'b0;  // Ensure start is initially deasserted
    coin=0;
    online_payment=0;
    #5;
    rst = 1'b0;    // Deassert reset
    #100;          // Wait for a few clock cycles after deasserting reset

    // Scenario 1
    start = 1'b1;  // Start the transaction 
    product_code = 3'b000; // Select Pen
    online_payment=1;         
    #30 start=1'b0; online_payment=0;
    #50
    start=1'b1;
    product_code=3'b001; // Notebook
    coin=50;
    #30 start=1'b0;
    #50
     start=1'b1;
     product_code=3'b100; // Water Bottle
     coin=50;
     #30 start=1'b0;
     #50
     start=1'b1;
     product_code=3'b100; // Water Bottle
     coin=50;
     cancel=1'b1;
     #30
    
    

    

    $finish;    
end

endmodule




