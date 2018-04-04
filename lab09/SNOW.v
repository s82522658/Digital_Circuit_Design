`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:08 12/23/2016 
// Design Name: 
// Module Name:    SNOW 
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
module SNOW(
	clk,
	col,
	row,
	snow_r,
	snow_c,
	snow_en
);
input clk;
input [10:0] col,row,snow_c,snow_r;
output reg [2:0]snow_en;
//output snow_en;

//wire [24:0] snow [0:16];
wire [24:0] r_a,r_b,r_c,r_d,r_e,r_f,r_g,r_h,r_i,r_j,r_k,r_l,r_m,r_n,r_o,r_p,r_q;
reg flag;
//reg [4:0]counter;

//assign snow_en=flag;

assign r_a = 25'b0000000000001000000000000;
assign r_b = 25'b0000000000011100000000000;
assign r_c = 25'b0000000000011100000000000;
assign r_d = 25'b0000011000111110001100000;
assign r_e = 25'b0000001110111110111000000;
assign r_f = 25'b0000001111111111111000000;
assign r_g = 25'b0011111111111111111111100;
assign r_h = 25'b0000111111111111111110000;
assign r_i = 25'b0000001111111111111000000;
assign r_j = 25'b0000001111111111111000000;
assign r_k = 25'b0000011111111111111100000;
assign r_l = 25'b0001111111111111111111000;
assign r_m = 25'b0000000111111111110000000;
assign r_n = 25'b0000000111111111110000000;
assign r_o = 25'b0000001111111111111000000;
assign r_p = 25'b0000001110011100111000000;
assign r_q = 25'b0000011000001000001100000;
/*
assign snow[0]  = 25'b0000000000001000000000000;
assign snow[1]  = 25'b0000000000011100000000000;
assign snow[2]  = 25'b0000000000011100000000000;
assign snow[3]  = 25'b0000011000111110001100000;
assign snow[4]  = 25'b0000001110111110111000000;
assign snow[5]  = 25'b0000001111111111111000000;
assign snow[6]  = 25'b0011111111111111111111100;
assign snow[7]  = 25'b0000111111111111111110000;
assign snow[8]  = 25'b0000001111111111111000000;
assign snow[9]  = 25'b0000001111111111111000000;
assign snow[10] = 25'b0000011111111111111100000;
assign snow[11] = 25'b0001111111111111111111000;
assign snow[12] = 25'b0000000111111111110000000;
assign snow[13] = 25'b0000000111111111110000000;
assign snow[14] = 25'b0000001111111111111000000;
assign snow[15] = 25'b0000001110011100111000000;
assign snow[16] = 25'b0000011000001000001100000;
*/
/*
//flag
always@(posedge clk) begin
	case(row-snow_r)
	//	0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16:flag<=snow[row-snow_r][col-snow_c];
        0 : flag <= snow[0] [col-snow_c];
		1 : flag <= snow[1] [col-snow_c];
		2 : flag <= snow[2] [col-snow_c];
		3 : flag <= snow[3] [col-snow_c];
		4 : flag <= snow[4] [col-snow_c];
		5 : flag <= snow[5] [col-snow_c];
		6 : flag <= snow[6] [col-snow_c];
		7 : flag <= snow[7] [col-snow_c];
		8 : flag <= snow[8] [col-snow_c];
		9 : flag <= snow[9] [col-snow_c];
		10: flag <= snow[10] [col-snow_c];
		11: flag <= snow[11] [col-snow_c];
		12: flag <= snow[12] [col-snow_c];
		13: flag <= snow[13] [col-snow_c];
		14: flag <= snow[14] [col-snow_c];
		15: flag <= snow[15] [col-snow_c];
		16: flag <= snow[16] [col-snow_c];
		default:flag<=0;
	endcase
end
*/
//flag
always@(*)begin
	case(row-snow_r)
		0 : flag <= r_a [col-snow_c];
		1 : flag <= r_b [col-snow_c];
		2 : flag <= r_c [col-snow_c];
		3 : flag <= r_d [col-snow_c];
		4 : flag <= r_e [col-snow_c];
		5 : flag <= r_f [col-snow_c];
		6 : flag <= r_g [col-snow_c];
		7 : flag <= r_h [col-snow_c];
		8 : flag <= r_i [col-snow_c];
		9 : flag <= r_j [col-snow_c];
		10: flag <= r_k [col-snow_c];
		11: flag <= r_l [col-snow_c];
		12: flag <= r_m [col-snow_c];
		13: flag <= r_n [col-snow_c];
		14: flag <= r_o [col-snow_c];
		15: flag <= r_p [col-snow_c];
		16: flag <= r_q [col-snow_c];
		default: flag<=0;
	endcase
end
//snow_en
always@(posedge clk) begin
	if(flag) snow_en<=3'b111;
	else snow_en<=3'b001;
end


endmodule
