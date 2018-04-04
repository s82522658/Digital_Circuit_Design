`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:49:09 12/19/2016 
// Design Name: 
// Module Name:    LCD 
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
module LCD(
	LCD_E,
	LCD_RS,
	LCD_RW,
	LCD_D,
	row_a,
	row_b,
	clk,
	btn_s
);

output LCD_E,LCD_RS,LCD_RW;
output [3:0] LCD_D;
input [103:0] row_a,row_b;
input clk,btn_s;

reg lcd_inited,refresh;
reg [5:0] comd;
reg [23:0] text_cnt;
reg [23:0] ini_cnt;

assign LCD_RS=comd[5];
assign LCD_RW=comd[4];
assign LCD_D=comd[3:0];
assign LCD_E=refresh;

always@(posedge clk or posedge btn_s) begin
	if(btn_s) begin
		text_cnt<=0;
		ini_cnt<=0;
		lcd_inited<=0;
		comd<=0;
	end
	else if(!lcd_inited) begin
		ini_cnt<=ini_cnt+1;
		case(ini_cnt[23:17])
			//initialization
			0:comd<=6'h03;
			1:comd<=6'h03;
			2:comd<=6'h03;
			3:comd<=6'h02;
			//function set
			4:comd<=6'b000010;
			5:comd<=6'b001000;
			//clear display
			6:comd<=6'b000000;
			7:comd<=6'b000001;
			//entry mode
			8:comd<=6'b000000;
			9:comd<=6'b000110;
			//display on/off
			10:comd<=6'b000000;
			11:comd<=6'b001100;
			
			default:lcd_inited<=1;			
		endcase
	end
	else begin
		comd[5:4]<=2'b10;
		text_cnt<=(text_cnt[23:17]<=22)?text_cnt+1:0;
		case(text_cnt[23:17])
		//move to first line
			0:comd<=6'b001000;
			1:comd<=6'b000000;
		//text
			2:comd[3:0]<=row_a[103:100];
			3:comd[3:0]<=row_a[99:96];
			4:comd[3:0]<=row_a[95:92];
			5:comd[3:0]<=row_a[91:88];
			6:comd[3:0]<=row_a[87:84];
			7:comd[3:0]<=row_a[83:80];
			8:comd[3:0]<=row_a[79:76];
			9:comd[3:0]<=row_a[75:72];
			10:comd[3:0]<=row_a[71:68];
			11:comd[3:0]<=row_a[67:64];
			12:comd[3:0]<=row_a[63:60];
			13:comd[3:0]<=row_a[59:56];
			14:comd[3:0]<=row_a[55:52];
			15:comd[3:0]<=row_a[51:48];
			//xx
			16:comd[3:0]<=row_a[47:44];
			17:comd[3:0]<=row_a[43:40];
			18:comd[3:0]<=row_a[39:36];
			19:comd[3:0]<=row_a[35:32];
			
			20:comd[3:0]<=row_a[31:28];
			21:comd[3:0]<=row_a[27:24];
			
			//move to second line
			22:comd<=6'b001100;
			23:comd<=6'b000000;
			
			24:comd[3:0]<=row_b[103:100];
			25:comd[3:0]<=row_b[99:96];
			26:comd[3:0]<=row_b[95:92];
			27:comd[3:0]<=row_b[91:88];
			28:comd[3:0]<=row_b[87:84];
			29:comd[3:0]<=row_b[83:80];
			30:comd[3:0]<=row_b[79:76];
			31:comd[3:0]<=row_b[75:72];
			32:comd[3:0]<=row_b[71:68];
			33:comd[3:0]<=row_b[67:64];
			34:comd[3:0]<=row_b[63:60];
			35:comd[3:0]<=row_b[59:56];
			36:comd[3:0]<=row_b[55:52];
			37:comd[3:0]<=row_b[51:48];
			//xx
			38:comd[3:0]<=row_b[47:44];
			39:comd[3:0]<=row_b[43:40];
			40:comd[3:0]<=row_b[39:36];
			41:comd[3:0]<=row_b[35:32];
			
			42:comd[3:0]<=row_b[31:28];
			43:comd[3:0]<=row_b[27:24];
			
			
			default:comd<=6'h10;
		endcase
	end
end	
//refresh	
always@(posedge clk or posedge btn_s) begin
	if(btn_s) refresh<=0;
	else if(!lcd_inited) refresh<=ini_cnt[16];
	else refresh<=text_cnt[16];
end	

endmodule