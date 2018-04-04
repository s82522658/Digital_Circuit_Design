`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:33 12/23/2016 
// Design Name: 
// Module Name:    STAR 
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
module sSTAR(
	clk,
	col,
	row,
	star_r,
	star_c,
    blink,
	star_en
);
input clk,blink;
//input clk;
input [10:0] col,row,star_r,star_c;
output reg [2:0] star_en;
//output star_en;

reg flag;
//wire [24:0]star[0:16];
wire [24:0] r_a,r_b,r_c,r_d,r_e,r_f,r_g,r_h,r_i,r_j,r_k,r_l,r_m,r_n,r_o,r_p,r_q;
//assign star_en=flag;
/* my ugly star
assign star[0] =11'b00000100000;
assign star[1] =11'b00000100000;
assign star[2] =11'b00001110000;
assign star[3] =11'b00011111000;
assign star[4] =11'b00111111100;
assign star[5] =11'b11111111111;
assign star[6] =11'b00111111000;
assign star[7] =11'b00011110000;
assign star[8] =11'b00110011000;
assign star[9] =11'b01100000110;
assign star[10]=11'b10000000001;
*/
/*assign star[0] = 25'b0000000000001000000000000;
assign star[1] = 25'b0000000000011100000000000;
assign star[2] = 25'b0000000000011100000000000;
assign star[3] = 25'b0000000000111110000000000;
assign star[4] = 25'b0000000000111110000000000;
assign star[5] = 25'b0000000001111111000000000;
assign star[6] = 25'b0011111111111111111111100;
assign star[7] = 25'b0000111111111111111110000;
assign star[8] = 25'b0000001111111111111000000;
assign star[9] = 25'b0000000111111111110000000;
assign star[10]= 25'b0000000011111111100000000;
assign star[11]= 25'b0000000011111111100000000;
assign star[12]= 25'b0000000111111111110000000;
assign star[13]= 25'b0000000111110111110000000;
assign star[14]= 25'b0000001111100011111000000;
assign star[15]= 25'b0000001110000000111000000;
assign star[16]= 25'b0000011000000000001100000;*/

assign r_a = 25'b0000000000001000000000000;
assign r_b = 25'b0000000000011100000000000;
assign r_c = 25'b0000000000011100000000000;
assign r_d = 25'b0000000000111110000000000;
assign r_e = 25'b0000000000111110000000000;
assign r_f = 25'b0000000001111111000000000;
assign r_g = 25'b0011111111111111111111100;
assign r_h = 25'b0000111111111111111110000;
assign r_i = 25'b0000001111111111111000000;
assign r_j = 25'b0000000111111111110000000;
assign r_k = 25'b0000000011111111100000000;
assign r_l = 25'b0000000011111111100000000;
assign r_m = 25'b0000000111111111110000000;
assign r_n = 25'b0000000111110111110000000;
assign r_o = 25'b0000001111100011111000000;
assign r_p = 25'b0000001110000000111000000;
assign r_q = 25'b0000011000000000001100000;
//flag
always@(*)begin
	case(row-star_r)
		0 : flag <= r_a [col-star_c];
		1 : flag <= r_b [col-star_c];
		2 : flag <= r_c [col-star_c];
		3 : flag <= r_d [col-star_c];
		4 : flag <= r_e [col-star_c];
		5 : flag <= r_f [col-star_c];
		6 : flag <= r_g [col-star_c];
		7 : flag <= r_h [col-star_c];
		8 : flag <= r_i [col-star_c];
		9 : flag <= r_j [col-star_c];
		10: flag <= r_k [col-star_c];
		11: flag <= r_l [col-star_c];
		12: flag <= r_m [col-star_c];
		13: flag <= r_n [col-star_c];
		14: flag <= r_o [col-star_c];
		15: flag <= r_p [col-star_c];
		16: flag <= r_q [col-star_c];
		default: flag<=0;
	endcase
end
/*
//flag
always@(posedge clk ) begin
	case(row-star_r)
	//0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16:flag<=star[row-star_r][col-star_c];
        0 : flag <= star[0] [col-star_c];
		1 : flag <= star[1] [col-star_c];
		2 : flag <= star[2] [col-star_c];
		3 : flag <= star[3] [col-star_c];
		4 : flag <= star[4] [col-star_c];
		5 : flag <= star[5] [col-star_c];
		6 : flag <= star[6] [col-star_c];
		7 : flag <= star[7] [col-star_c];
		8 : flag <= star[8] [col-star_c];
		9 : flag <= star[9] [col-star_c];
		10: flag <= star[10] [col-star_c];
		11: flag <= star[11] [col-star_c];
		12: flag <= star[12] [col-star_c];
		13: flag <= star[13] [col-star_c];
		14: flag <= star[14] [col-star_c];
		15: flag <= star[15] [col-star_c];
		16: flag <= star[16] [col-star_c];
        
    /*case(row)
	//central star
		58:flag<=star[0][col-388];
		59:flag<=star[1][col-388];
		60:flag<=star[2][col-388];
		61:flag<=star[3][col-388];
		62:flag<=star[4][col-388];
		63:flag<=star[5][col-388];
		64:flag<=star[6][col-388];
		65:flag<=star[7][col-388];
		66:flag<=star[8][col-388];
		67:flag<=star[9][col-388];
		68:flag<=star[10][col-388];
		69:flag<=star[11][col-388];
		70:flag<=star[12][col-388];
		71:flag<=star[13][col-388];
		72:flag<=star[14][col-388];
		73:flag<=star[15][col-388];
		74:flag<=star[16][col-388];
	//layer1
		150:flag<=(star[0][col-313]||star[0][col-463]);	
		151:flag<=(star[1][col-313]||star[1][col-463]);
		152:flag<=(star[2][col-313]||star[2][col-463]);
		153:flag<=(star[3][col-313]||star[3][col-463]);
		154:flag<=(star[4][col-313]||star[4][col-463]);
		155:flag<=(star[5][col-313]||star[5][col-463]);
		156:flag<=(star[6][col-313]||star[6][col-463]);
		157:flag<=(star[7][col-313]||star[7][col-463]);
		158:flag<=(star[8][col-313]||star[8][col-463]);
		159:flag<=(star[9][col-313]||star[9][col-463]);
		160:flag<=(star[10][col-313]||star[10][col-463]);
		161:flag<=(star[11][col-313]||star[11][col-463]);
		162:flag<=(star[12][col-313]||star[12][col-463]);
		163:flag<=(star[13][col-313]||star[13][col-463]);
		164:flag<=(star[14][col-313]||star[14][col-463]);
		165:flag<=(star[15][col-313]||star[15][col-463]);
		166:flag<=(star[16][col-313]||star[16][col-463]);
	//layer2	
		275:flag<=(star[0][col-263]||star[0][col-513]);	
		276:flag<=(star[1][col-263]||star[1][col-513]);
		277:flag<=(star[2][col-263]||star[2][col-513]);
		278:flag<=(star[3][col-263]||star[3][col-513]);
		279:flag<=(star[4][col-263]||star[4][col-513]);
		280:flag<=(star[5][col-263]||star[5][col-513]);
		281:flag<=(star[6][col-263]||star[6][col-513]);
		282:flag<=(star[7][col-263]||star[7][col-513]);
		283:flag<=(star[8][col-263]||star[8][col-513]);
		284:flag<=(star[9][col-263]||star[9][col-513]);
		285:flag<=(star[10][col-263]||star[10][col-513]);
		286:flag<=(star[11][col-263]||star[11][col-513]);
		287:flag<=(star[12][col-263]||star[12][col-513]);
		288:flag<=(star[13][col-263]||star[13][col-513]);
		289:flag<=(star[14][col-263]||star[14][col-513]);
		290:flag<=(star[15][col-263]||star[15][col-513]);
		291:flag<=(star[16][col-263]||star[16][col-513]);
	//layer3	
		450:flag<=(star[0][col-213]||star[0][col-563]);	
		451:flag<=(star[1][col-213]||star[1][col-563]);
		452:flag<=(star[2][col-213]||star[2][col-563]);
		453:flag<=(star[3][col-213]||star[3][col-563]);
		454:flag<=(star[4][col-213]||star[4][col-563]);
		455:flag<=(star[5][col-213]||star[5][col-563]);
		456:flag<=(star[6][col-213]||star[6][col-563]);
		457:flag<=(star[7][col-213]||star[7][col-563]);
		458:flag<=(star[8][col-213]||star[8][col-563]);
		459:flag<=(star[9][col-213]||star[9][col-563]);
		460:flag<=(star[10][col-213]||star[10][col-563]);
		461:flag<=(star[11][col-213]||star[11][col-563]);
		462:flag<=(star[12][col-213]||star[12][col-563]);
		463:flag<=(star[13][col-213]||star[13][col-563]);
		464:flag<=(star[14][col-213]||star[14][col-563]);
		465:flag<=(star[15][col-213]||star[15][col-563]);
		466:flag<=(star[16][col-213]||star[16][col-563]);
		
		//17x25
		default:flag<=0;
	endcase
end
*/
//star_en
always@(posedge clk) begin
	if(flag) begin
		if(blink) star_en<=3'b111;//white
		else star_en<=3'b110;//yellow
	end
	else star_en<=3'b001;//blue
end


endmodule