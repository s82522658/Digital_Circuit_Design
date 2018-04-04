`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:46:10 12/12/2016 
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
	sw,
	btn_s,
	btn_w,
	btn_e,
	btn_n,
	clk,
	led,
	SF_D,
	LCD_E,
	LCD_RS,
	LCD_RW
    );
	 
input clk;
input [3:0] sw;
input btn_s,btn_w,btn_e,btn_n;

output reg [7:0]led;
output  [3:0]SF_D;
output  LCD_E,LCD_RS,LCD_RW;
reg [3:0]ans;


reg [151:0] row_a,row_b;//last,current
reg [7:0] total,temp,led_t;
reg [1:0] btn_t,flag;
reg [15:0] count;
reg [27:0] ini_cnt;
reg [23:0] text_cnt;
reg [5:0] comd;
reg refresh,lcd_inited,num,ten;

wire [7:0] out_t;
wire [3:0]fractional,fractional1,fractional2,fractional3;
wire  rfd,rfd1,rfd2,rfd3;
wire[7:0] quo,quo_t,quoh,quoh_t;

parameter RST=2'd0;
parameter ROOT=2'd1;
parameter MULT=2'd2;
parameter ADD=2'd3;

div d1(
	.clk(clk), // input clk
	.rfd(rfd), // output rfd
	.dividend(led), // input [15 : 0] dividend
	.divisor(10), // input [15 : 0] divisor
	.quotient(quo), // output [15 : 0] quotient
	.fractional(fractional)
	); 
div d2(
	.clk(clk), // input clk
	.rfd(rfd1), // output rfd
	.dividend(led_t), // input [15 : 0] dividend
	.divisor(10), // input [15 : 0] divisor
	.quotient(quo_t), // output [15 : 0] quotient
	.fractional(fractional1)
	);
div d3(
	.clk(clk), // input clk
	.rfd(rfd2), // output rfd
	.dividend(led), // input [15 : 0] dividend
	.divisor(100), // input [15 : 0] divisor
	.quotient(quoh), // output [15 : 0] quotient
	.fractional(fractional2)
	); 
div d4(
	.clk(clk), // input clk
	.rfd(rfd3), // output rfd
	.dividend(led_t), // input [15 : 0] dividend
	.divisor(100), // input [15 : 0] divisor
	.quotient(quoh_t), // output [15 : 0] quotient
	.fractional(fractional3)
	); 	

root r1(.x_in(total), // input [15 : 0] x_in
		.x_out(out_t), // output [8 : 0] x_out
		.clk(clk) // input clk
		);
/*answer a1(.led_t(led_t), // input [15 : 0] x_in
		.led(led), // output [8 : 0] x_out
		.clk(clk),
		.btn_s(btn_s),// input clk
		.ans(ans)
		);
*/
assign SF_D=comd[3:0];
assign LCD_RW=comd[4];
assign LCD_RS=comd[5];	
assign LCD_E = refresh;
	
//row_a,row_b
always@(posedge clk or posedge btn_s) begin
	if(btn_s) begin
		row_a<=152'h4c617374fe616e737765723d30303000000000;
		row_b<=152'h43757272656e74fe616e737765723d30303000;
	end
	else begin
		row_a<=row_a;
		row_b<=row_b;
	end
end
//comd,lcd_inited,ini_cnt,text_cnt,num
always@(posedge clk or posedge btn_s)begin
	if(btn_s==1) begin
		comd<=0;
		lcd_inited<=0;
		ini_cnt<=0;
		text_cnt<=0;
	end	
	else if (!lcd_inited) begin
		ini_cnt<=ini_cnt+1;
		
		case(ini_cnt[27:21])
		//initialization
			0:comd<=6'h03;
			1:comd<=6'h03;
			2:comd<=6'h03;
			3:comd<=6'h02;
		//set funtion
			4:comd<=6'h02;//000010
			5:comd<=6'h08;//001000
		//display shift	
			6:comd<=6'h01;//000001
			7:comd<=6'h08;//001000
		//display on/off
			8:comd<=6'h00;//000000
			9:comd<=6'h0c;//001100
		//clear display
			10:comd<=6'h00;//000000
			11:comd<=6'h01;//000001
			default:lcd_inited<=1;			
		endcase	
	end
	else begin
		text_cnt<=(text_cnt[23:17]<=120)? text_cnt+1 :0;
		comd[5:4]<=2'b10;
		
		case(text_cnt[23:17])
		//display characters
			0:comd[3:0]<=row_a[151:148];
			1:comd[3:0]<=row_a[147:144];
			2:comd[3:0]<=row_a[143:140];
			3:comd[3:0]<=row_a[139:136];
			4:comd[3:0]<=row_a[135:132];
			5:comd[3:0]<=row_a[131:128];
			6:comd[3:0]<=row_a[127:124];
			7:comd[3:0]<=row_a[123:120];
			8:comd[3:0]<=row_a[119:116];
			9:comd[3:0]<=row_a[115:112];
			10:comd[3:0]<=row_a[111:108];
			11:comd[3:0]<=row_a[107:104];
			12:comd[3:0]<=row_a[103:100];
			13:comd[3:0]<=row_a[99:96];
			14:comd[3:0]<=row_a[95:92];
			15:comd[3:0]<=row_a[91:88];
			16:comd[3:0]<=row_a[87:84];
			17:comd[3:0]<=row_a[83:80];
			18:comd[3:0]<=row_a[79:76];
			19:comd[3:0]<=row_a[75:72];
			20:comd[3:0]<=row_a[71:68];
			21:comd[3:0]<=row_a[67:64];
			22:comd[3:0]<=row_a[63:60];
			23:comd[3:0]<=row_a[59:56];
		//xxx	
			24:begin
				num<=1;
				ten<=1;
				comd[3:0]<=row_a[55:52];
			end
			25:begin
				Ans_t;
				comd[3:0]<=ans;
			end	
			26:begin
				num<=0;
				ten<=1;
				comd[3:0]<=row_a[47:44];
			end
			27:begin
				Ans_t;
				comd[3:0]<=ans;
			end
			28:begin
				num<=1;
				ten<=0;
				comd[3:0]<=row_a[39:36];
			end
			29:begin
				Ans_t;
				comd[3:0]<=ans;
			end
			
		//move to second line
			30:comd<=6'b001100;
			31:comd<=6'b000000;
			
			32:comd[3:0]<=row_b[151:148];
			33:comd[3:0]<=row_b[147:144];
			34:comd[3:0]<=row_b[143:140];
			35:comd[3:0]<=row_b[139:136];
			36:comd[3:0]<=row_b[135:132];
			37:comd[3:0]<=row_b[131:128];
			38:comd[3:0]<=row_b[127:124];
			39:comd[3:0]<=row_b[123:120];
			40:comd[3:0]<=row_b[119:116];
			41:comd[3:0]<=row_b[115:112];
			42:comd[3:0]<=row_b[111:108];
			43:comd[3:0]<=row_b[107:104];
			44:comd[3:0]<=row_b[103:100];
			45:comd[3:0]<=row_b[99:96];
			46:comd[3:0]<=row_b[95:92];
			47:comd[3:0]<=row_b[91:88];
			48:comd[3:0]<=row_b[87:84];
			49:comd[3:0]<=row_b[83:80];
			50:comd[3:0]<=row_b[79:76];
			51:comd[3:0]<=row_b[75:72];
			52:comd[3:0]<=row_b[71:68];
			53:comd[3:0]<=row_b[67:64];
			54:comd[3:0]<=row_b[63:60];
			55:comd[3:0]<=row_b[59:56];
			56:comd[3:0]<=row_b[55:52];
			57:comd[3:0]<=row_b[51:48];
			58:comd[3:0]<=row_b[47:44];
			59:comd[3:0]<=row_b[43:40];
			60:comd[3:0]<=row_b[39:36];
			61:comd[3:0]<=row_b[35:32];
		//xxx	
			62:begin
				num<=1;
				ten<=1;
				comd[3:0]<=row_b[31:28];
			end	
			63:begin
				Ans;
				comd[3:0]<=ans;
			end
			64:begin
				num<=0;
				ten<=1;
				comd[3:0]<=row_b[23:20];
			end	
			65:begin
				Ans;
				comd[3:0]<=ans;
			end
			66:begin
				num<=1;
				ten<=0;
				comd[3:0]<=row_b[15:12];
			end
			67:begin
				Ans;
				comd[3:0]<=ans;
			end	
		//move to first line
			69:comd<=6'b001000;
			70:comd<=6'b000000;
		//display shift	
			71:comd<=6'h01;
			72:comd<=6'h08;
		default:comd<=6'h10;	
		endcase	
	end
end

//refresh
always@(posedge clk or posedge btn_s) begin
	if(btn_s==1) refresh<=0;
	else if(!lcd_inited) refresh<=ini_cnt[20];
	else refresh<=text_cnt[16];
end
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

//led,led_t
always@(posedge clk or posedge btn_s) begin
	if(btn_s) begin
		led<=0;
		led_t<=0;
	end
	else if(flag==0) begin
		case(btn_t)
			ROOT:begin
				if(out_t==led)
					led<=out_t;
				else begin
					led_t<=led;
					led<=out_t;
				end
			end
			MULT:begin
				if(temp*total==led)
					led<=temp*total;
				else begin
					led_t<=led;
					led<=temp*total;
				end
			end
			ADD:begin
				if((temp+total)==led)
					led<=(temp+total);
				else begin
					led_t<=led;
					led<=(temp+total);
				end
			end
			RST:begin
				if(total==led)led<=total;
				else begin
					led_t<=led;
					led<=total;
				end
			end
		endcase
	end	
	else led<=led;
end

task Ans_t; begin
	if(led_t<10) begin
		if(num&&!ten) ans<=led_t;
		else ans<=4'h0;
	end
	else if(led_t>=10&&led_t<100) begin
		if(num&&!ten) ans<=led_t-(quo_t*10);
		else if (!num&&ten) ans<=quo_t;
		else ans<=4'h0;
	end
	else if(led_t>=100&&led_t<1000)begin
		if(num&&!ten) ans<=led_t-(quo_t*10);
		else if(!num&&ten) ans<=quo_t-(quoh_t*10);
		else ans<=quoh_t;
	end
end
endtask

task Ans; begin
	if(led<10) begin
		if(num&&!ten) ans<=led;
		else ans<=4'h0;
	end
	else if(led>=10&&led<100) begin
		if(num&&!ten) ans<=led-(quo*10);
		else if(!num&&ten)ans<=quo;
		else ans<=4'h0;
	end
	else if(led>=100&&led<1000)begin
		if(num&&!ten) ans<=led-(quo*10);
		else if(!num&&ten) ans<=quo-(quoh*10);
		else ans<=quoh;
		
	end
end
endtask

endmodule
