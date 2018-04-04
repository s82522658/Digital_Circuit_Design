`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:47 12/23/2016 
// Design Name: 
// Module Name:    TREE 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module TREE(
	clk,
	col,
	row,
	tree_en
);

input clk;
input [10:0] col,row;
output reg [2:0] tree_en;
//output tree_en;

reg flag;
//assign tree_en=flag;


always@(posedge clk) begin
		if( row >=75 & row < 150 & col >= 400-(row-75) & col <= 400+(row-75) ) tree_en <= 3'b010;//green
        else if( row >=150 & row < 275 & col >= 400-(row-150) & col <= 400+(row-150) ) tree_en <= 3'b010;//green
        else if( row >=275 & row < 450 & col >= 400-(row-275) & col <= 400+(row-275) ) tree_en <= 3'b010;//green
        else if ( row >=450 & row < 600 & col >= 365 & col <= 435 ) tree_en <= 3'b000;//black
        else tree_en<=3'b001;//blue
end
/*
always@(posedge clk) begin
	if( row >=75 & row < 150 & col >= 400-(row-75) & col <= 400+(row-75) ) flag<=1;
	else if( row >=150 & row < 275 & col >= 400-(row-150) & col <= 400+(row-150) ) flag<=1;
	else if( row >=275 & row < 450 & col >= 400-(row-275) & col <= 400+(row-275) ) flag<=1;
	else if ( row >=450 & row < 600 & col >= 365 & col <= 435 ) flag<=1;
	else flag<=0;//blue
end
*/

endmodule