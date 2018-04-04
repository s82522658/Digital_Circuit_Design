`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:16 12/07/2016 
// Design Name: 
// Module Name:    CAL 
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
module CAL(
	sw,
	btn_s,
	btn_w,
	btn_e,
	btn_n,
	clk,
	led
    );
	 
input clk;
input [3:0] sw;
input btn_s,btn_w,btn_e,btn_n;

output reg [7:0]led;


wire [7:0] out_t;
reg [7:0] total,temp;
reg [1:0] btn_t,flag;
reg [15:0] count;


parameter RST=2'd0;
parameter ROOT=2'd1;
parameter MULT=2'd2;
parameter ADD=2'd3;


root r1(.x_in(total), // input [15 : 0] x_in
		.x_out(out_t), // output [8 : 0] x_out
		.clk(clk) // input clk
		);


//count
always@(posedge clk or posedge btn_s)begin
	if(btn_s==1) count<=0;
	else if((btn_n||btn_e||btn_w)&&count<16'b1111111111111111) count<=count+1;//當button有辦法被壓超過n秒才算數
	else if((btn_n||btn_e||btn_w)&&count==16'b1111111111111111) count<=count;
	else count<=0;
end
//flag
always@(posedge clk or posedge btn_s) begin
	if(btn_s==1) flag<=0;
	else if(count==16'b1111111111111111&&flag==0)flag<=1;
	else if(flag==1) flag<=flag+1;//bad coding style
	else if((!(btn_n||btn_e||btn_w))&&count==16'b1111111111111111) flag<=0;
	else flag<=flag;
end

//btn_t
always@(posedge clk or posedge btn_s) begin
	if(btn_s) btn_t<=RST;
	else if(flag==1) begin//原本放count==16'b111..不行 因為放手的瞬間btn==0 就會跑到else 故只存到btn_t=rst
		if(btn_n)btn_t<=MULT;
		else if(btn_e) btn_t<=ADD;
		else if(btn_w) btn_t<=ROOT;
		else btn_t<=RST;
	end
	else btn_t<=btn_t;
end

//temp
always@(posedge clk or posedge btn_s) begin
	if(btn_s) temp<=0;
	else temp<=sw;
end

//total
always@(posedge clk or posedge btn_s) begin
	if(btn_s) total<=0;
	else if(btn_t==RST) total<=sw;
	else if(flag==1) total<=led;//上一次led的結果
	else total<=total;
end

//led
always@(posedge clk or posedge btn_s) begin
	if(btn_s) led<=0;
	else if(flag==0) begin
		case(btn_t)
			ROOT:led<=out_t;
			MULT:led<=temp*total;
			ADD:led<=temp+total;
			RST:led<=total;
		endcase
	end	
	else led<=led;
end

endmodule
