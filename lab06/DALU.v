`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:24 11/17/2016 
// Design Name: 
// Module Name:    DLAU 
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
module DALU(
    // Input signals
	clk,
	rst,
	in_valid,
	instruction,
  // Output signals
  out_valid,
  out
	/*dbg_s,
	dbg_t,
	dbg_fun,
	dbg_i,
	dbg_op*/
    );
	 
/*output signed [2:0] dbg_op;
output signed [5:0] dbg_s,dbg_t;
output signed [3:0] dbg_fun;
output signed [9:0] dbg_i;*/



input signed [18:0] instruction;
input clk,rst,in_valid;
output reg signed [15:0] out;
output reg out_valid;


reg signed [2:0] op;
reg signed [5:0] s,t;
reg signed [3:0] fun;
reg signed [9:0] i;

reg count;
//reg signed [18:0] in_t;
/*
assign dbg_s=s;
assign dbg_t=t;
assign dbg_fun=fun;
assign dbg_i=i;
assign dbg_op=op;
*/
//out
always@(posedge clk) begin
	if(rst==1) out<=0;
	else if(count==1) begin
		if(op==3'b000) begin
			case(fun)
				4'b0000:out<=s&t;
				4'b0001:out<=s|t;
				4'b0010:out<=s^t;
				4'b0011:out<=s+t;
				4'b0100:out<=s-t;
				default:out<=0;
			endcase
		end
		else if(op==3'b001) out<=s*t*fun;
		else if(op==3'b010) out<=(s+t+fun)*(s+t+fun);
		else if(op==3'b011) out<=s+i;
		else if(op==3'b100) out<=s-i;
		else out<=0;
	end
	else out<=0;
end
//out_valid
always@(posedge clk) begin
	if(rst==1) out_valid<=0;
	else if(count==1) out_valid<=1;
	else out_valid<=0;
end
//count 
always@(posedge clk) begin
	if(rst==1) count<=0;
	else if(in_valid==1) count<=1;
	else count<=0;
end
/*
//in_t
always@(posedge clk or negedge rst) begin
	if(rst==1) in_t<=0;
	else if(in_valid==1) in_t<=instruction;
	else in_t<=in_t;
end
*/
//op
always@(posedge clk) begin
	if(rst==1) op<=0;
	else if(in_valid==1) op<=instruction[18:16];
	else op<=op;
end
//s
always@(posedge clk) begin
	if(rst==1) s<=0;
	else if(in_valid==1) s<=instruction[15:10];
	else s<=s;
end
//t
always@(posedge clk) begin
	if(rst==1) t<=0;
	else if(in_valid==1&&instruction[18:16]==3'b000||instruction[18:16]==3'b001||instruction[18:16]==3'b010) t<=instruction[9:4];
	else t<=t;
end
//i
always@(posedge clk) begin
	if(rst==1) i<=0;
	else if(in_valid==1&&instruction[18:16]==3'b011||instruction[18:16]==3'b100) i<=instruction[9:0];
	else i<=i;
end
//fun
always@(posedge clk) begin
	if(rst==1) fun<=0;
	else if(in_valid==1&&instruction[18:16]==3'b000||instruction[18:16]==3'b001||instruction[18:16]==3'b010) fun<=instruction[3:0];
	else fun<=fun;
end


endmodule
