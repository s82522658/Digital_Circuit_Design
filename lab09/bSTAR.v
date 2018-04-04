`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:32:33 12/23/2016 
// Design Name: 
// Module Name:    bSTAR 
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
module bSTAR(
	clk,
	col,
	row,
	star_c,
	star_r,
    blink,
	star_en
);
input clk;
input [1:0] blink;
input [10:0] col,row,star_c,star_r;
output reg [2:0]star_en;
//output star_en;

reg flag;
//reg[6:0] counter;
//wire [102:0] star[0:95];
wire [102:0] stara,starb,starc,stard,stare,
             starf,starg,starh,stari,starj,
             stark,starl,starm,starn,staro,
             starp,starq,starr,stars,start,
             staru,starv,starw,starx,stary,
             starz,staraa,starab,starac,starad,
             starae,staraf,starag,starah,starai,
             staraj,starak,staral,staram,staran,
             starao,starap,staraq,starar,staras,
             starat,starau,starav,staraw,starax,
             staray,staraz,starba,starbb,starbc,
             starbd,starbe,starbf,starbg,starbh,
             starbi,starbj,starbk,starbl,starbm,
             starbn,starbo,starbp,starbq,starbr,
             starbs,starbt,starbu,starbv,starbw,
             starbx,starby,starbz,starca,starcb,
             starcc,starcd,starce,starcf,starcg,
             starch,starci,starcj,starck,starcl,
             starcm,starcn,starco,starcp,starcq,
             starcr;
//assign star_en =flag;

//hight 96 width 103
assign stara  = 103'b0000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000;
assign starb  = 103'b0000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000;
assign starc  = 103'b0000000000000000000000000000000000000000000000000011100000000000000000000000000000000000000000000000000;
assign stard  = 103'b0000000000000000000000000000000000000000000000000011100000000000000000000000000000000000000000000000000;
assign stare  = 103'b0000000000000000000000000000000000000000000000000011100000000000000000000000000000000000000000000000000;
assign starf  = 103'b0000000000000000000000000000000000000000000000000011100000000000000000000000000000000000000000000000000;
assign starg  = 103'b0000000000000000000000000000000000000000000000000111110000000000000000000000000000000000000000000000000;
assign starh  = 103'b0000000000000000000000000000000000000000000000000111110000000000000000000000000000000000000000000000000;
assign stari  = 103'b0000000000000000000000000000000000000000000000001111111000000000000000000000000000000000000000000000000;
assign starj  = 103'b0000000000000000000000000000000000000000000000001111111000000000000000000000000000000000000000000000000;
assign stark  = 103'b0000000000000000000000000000000000000000000000001111111000000000000000000000000000000000000000000000000;
assign starl  = 103'b0000000000000000000000000000000000000000000000011111111100000000000000000000000000000000000000000000000;
assign starm  = 103'b0000000000000000000000000000000000000000000000011111111100000000000000000000000000000000000000000000000;
assign starn  = 103'b0000000000000000000000000000000000000000000000011111111100000000000000000000000000000000000000000000000;
assign staro  = 103'b0000000000000000000000000000000000000000000000111111111110000000000000000000000000000000000000000000000;
assign starp  = 103'b0000000000000000000000000000000000000000000000111111111110000000000000000000000000000000000000000000000;
assign starq  = 103'b0000000000000000000000000000000000000000000001111111111111000000000000000000000000000000000000000000000;
assign starr  = 103'b0000000000000000000000000000000000000000000001111111111111000000000000000000000000000000000000000000000;
assign stars  = 103'b0000000000000000000000000000000000000000000001111111111111000000000000000000000000000000000000000000000;
assign start  = 103'b0000000000000000000000000000000000000000000001111111111111000000000000000000000000000000000000000000000;
assign staru  = 103'b0000000000000000000000000000000000000000000011111111111111100000000000000000000000000000000000000000000;
assign starv  = 103'b0000000000000000000000000000000000000000000011111111111111100000000000000000000000000000000000000000000;
assign starw  = 103'b0000000000000000000000000000000000000000000011111111111111100000000000000000000000000000000000000000000;
assign starx  = 103'b0000000000000000000000000000000000000000000111111111111111110000000000000000000000000000000000000000000;
assign stary  = 103'b0000000000000000000000000000000000000000000111111111111111110000000000000000000000000000000000000000000;
assign starz  = 103'b0000000000000000000000000000000000000000000111111111111111110000000000000000000000000000000000000000000;
assign staraa = 103'b0000000000000000000000000000000000000000000111111111111111110000000000000000000000000000000000000000000;
assign starab = 103'b0000000000000000000000000000000000000000001111111111111111111000000000000000000000000000000000000000000;
assign starac = 103'b0000000000000000000000000000000000000000001111111111111111111000000000000000000000000000000000000000000;
assign starad = 103'b0000000000000000000000000000000000000000001111111111111111111000000000000000000000000000000000000000000;
assign starae = 103'b0000000000000000000000000000000000000000011111111111111111111100000000000000000000000000000000000000000;
assign staraf = 103'b0000000000000000000000000000000000000000011111111111111111111100000000000000000000000000000000000000000;
assign starag = 103'b0000000000000000000000000000000000000000111111111111111111111110000000000000000000000000000000000000000;
assign starah = 103'b0000000000000000000000000000000000000000111111111111111111111110000000000000000000000000000000000000000;
assign starai = 103'b0000000000000000000000000000000000000000111111111111111111111110000000000000000000000000000000000000000;
assign staraj = 103'b0000000000000000000000000000000000000000111111111111111111111110000000000000000000000000000000000000000;
assign starak = 103'b1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111;//central
assign staral = 103'b0111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110;
assign staram = 103'b0001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111000;
assign staran = 103'b0000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000;
assign starao = 103'b0000011111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111100000;
assign starap = 103'b0000000111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110000000;
assign staraq = 103'b0000000011111111111111111111111111111111111111111111111111111111111111111111111111111111111111100000000;
assign starar = 103'b0000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111000000000;
assign staras = 103'b0000000000111111111111111111111111111111111111111111111111111111111111111111111111111111111110000000000;
assign starat = 103'b0000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111000000000000;
assign starau = 103'b0000000000000111111111111111111111111111111111111111111111111111111111111111111111111111110000000000000;
assign starav = 103'b0000000000000011111111111111111111111111111111111111111111111111111111111111111111111111100000000000000;
assign staraw = 103'b0000000000000000111111111111111111111111111111111111111111111111111111111111111111111110000000000000000;
assign starax = 103'b0000000000000000011111111111111111111111111111111111111111111111111111111111111111111100000000000000000;
assign staray = 103'b0000000000000000001111111111111111111111111111111111111111111111111111111111111111111000000000000000000;
assign staraz = 103'b0000000000000000000011111111111111111111111111111111111111111111111111111111111111100000000000000000000;
assign starba = 103'b0000000000000000000001111111111111111111111111111111111111111111111111111111111111000000000000000000000;
assign starbb = 103'b0000000000000000000000111111111111111111111111111111111111111111111111111111111110000000000000000000000;
assign starbc = 103'b0000000000000000000000001111111111111111111111111111111111111111111111111111111000000000000000000000000;
assign starbd = 103'b0000000000000000000000000111111111111111111111111111111111111111111111111111110000000000000000000000000;
assign starbe = 103'b0000000000000000000000000011111111111111111111111111111111111111111111111111100000000000000000000000000;
assign starbf = 103'b0000000000000000000000000001111111111111111111111111111111111111111111111111000000000000000000000000000;
assign starbg = 103'b0000000000000000000000000000011111111111111111111111111111111111111111111100000000000000000000000000000;
assign starbh = 103'b0000000000000000000000000000001111111111111111111111111111111111111111111000000000000000000000000000000;//72
assign starbi = 103'b0000000000000000000000000000001111111111111111111111111111111111111111111000000000000000000000000000000;
assign starbj = 103'b0000000000000000000000000000001111111111111111111111111111111111111111111000000000000000000000000000000;
assign starbk = 103'b0000000000000000000000000000011111111111111111111111111111111111111111111100000000000000000000000000000;
assign starbl = 103'b0000000000000000000000000000011111111111111111111111111111111111111111111100000000000000000000000000000;
assign starbm = 103'b0000000000000000000000000000011111111111111111111111111111111111111111111100000000000000000000000000000;
assign starbn = 103'b0000000000000000000000000000111111111111111111111111111111111111111111111110000000000000000000000000000;
assign starbo = 103'b0000000000000000000000000000111111111111111111111111111111111111111111111110000000000000000000000000000;
assign starbp = 103'b0000000000000000000000000000111111111111111111111111111111111111111111111110000000000000000000000000000;
assign starbq = 103'b0000000000000000000000000001111111111111111111111111111111111111111111111111000000000000000000000000000;
assign starbr = 103'b0000000000000000000000000001111111111111111111111111111111111111111111111111000000000000000000000000000;
assign starbs = 103'b0000000000000000000000000001111111111111111111111111111111111111111111111111000000000000000000000000000;
assign starbt = 103'b0000000000000000000000000011111111111111111111111111111111111111111111111111100000000000000000000000000;
assign starbu = 103'b0000000000000000000000000011111111111111111111111111111111111111111111111111100000000000000000000000000;
assign starbv = 103'b0000000000000000000000000011111111111111111111111100011111111111111111111111100000000000000000000000000;
assign starbw = 103'b0000000000000000000000000011111111111111111111110000000111111111111111111111100000000000000000000000000;
assign starbx = 103'b0000000000000000000000000111111111111111111111100000000011111111111111111111110000000000000000000000000;
assign starby = 103'b0000000000000000000000000111111111111111111111000000000001111111111111111111110000000000000000000000000;
assign starbz = 103'b0000000000000000000000001111111111111111111100000000000000011111111111111111111000000000000000000000000;
assign starca = 103'b0000000000000000000000001111111111111111111000000000000000001111111111111111111000000000000000000000000;
assign starcb = 103'b0000000000000000000000001111111111111111100000000000000000000011111111111111111000000000000000000000000;
assign starcc = 103'b0000000000000000000000001111111111111111000000000000000000000001111111111111111000000000000000000000000;
assign starcd = 103'b0000000000000000000000011111111111111100000000000000000000000000011111111111111100000000000000000000000;
assign starce = 103'b0000000000000000000000011111111111111000000000000000000000000000001111111111111100000000000000000000000;
assign starcf = 103'b0000000000000000000000011111111111110000000000000000000000000000000111111111111100000000000000000000000;
assign starcg = 103'b0000000000000000000000111111111111000000000000000000000000000000000001111111111110000000000000000000000;
assign starch = 103'b0000000000000000000000111111111110000000000000000000000000000000000000111111111110000000000000000000000;
assign starci = 103'b0000000000000000000000111111111100000000000000000000000000000000000000011111111110000000000000000000000;
assign starcj = 103'b0000000000000000000001111111111000000000000000000000000000000000000000001111111111000000000000000000000;
assign starck = 103'b0000000000000000000001111111100000000000000000000000000000000000000000000011111111000000000000000000000;
assign starcl = 103'b0000000000000000000001111111000000000000000000000000000000000000000000000001111111000000000000000000000;
assign starcm = 103'b0000000000000000000011111100000000000000000000000000000000000000000000000000011111100000000000000000000;
assign starcn = 103'b0000000000000000000011111000000000000000000000000000000000000000000000000000001111100000000000000000000;
assign starco = 103'b0000000000000000000011110000000000000000000000000000000000000000000000000000000111100000000000000000000;
assign starcp = 103'b0000000000000000000011000000000000000000000000000000000000000000000000000000000001100000000000000000000;
assign starcq = 103'b0000000000000000000110000000000000000000000000000000000000000000000000000000000000110000000000000000000;
assign starcr = 103'b0000000000000000000100000000000000000000000000000000000000000000000000000000000000010000000000000000000;

//flag
always@(*) begin
	case(row-star_r)
		/*27,28,29,30,31,32,33,34,35,36,
		37,38,39,40,41,42,43,44,45,46,
		47,48,49,50,51,52,53,54,55,56,
		57,58,59,60,61,62,63,64,65,66,
		67,68,69,70,71,72,73,74,75,76,
		77,78,79,80,81,82,83,84,85,86,
		87,88,89,90,91,92,93,94,95,96,
		97,98,99,100,101,102,103,104,105,106,
		107,108,109,110,111,112,113,114,115,116,
		117,118,119,120,121,122*/
		/*0,1,2,3,4,5,6,7,8,9,
		10,11,12,13,14,15,16,17,18,19,
		20,21,22,23,24,25,26,27,28,29,
		30,31,32,33,34,35,36,37,38,39,
		40,41,42,43,44,45,46,47,48,49,
		50,51,52,53,54,55,56,57,58,59,
		60,61,62,63,64,65,66,67,68,69,
		70,71,72,73,74,75,76,77,78,79,
		80,81,82,83,84,85,86,87,88,89,
		90,91,92,93,94,95:flag<=star[row-star_r][col-star_c];*/
        0 : flag <= stara [col-star_c];
		1 : flag <= starb [col-star_c];
		2 : flag <= starc [col-star_c];
		3 : flag <= stard [col-star_c];
		4 : flag <= stare [col-star_c];
		5 : flag <= starf [col-star_c];
		6 : flag <= starg [col-star_c];
		7 : flag <= starh [col-star_c];
		8 : flag <= stari [col-star_c];
		9 : flag <= starj [col-star_c];
		
        10: flag <= stark [col-star_c];
		11: flag <= starl [col-star_c];
		12: flag <= starm [col-star_c];
		13: flag <= starn [col-star_c];
		14: flag <= staro [col-star_c];
		15: flag <= starp [col-star_c];
		16: flag <= starq [col-star_c];
        17: flag <= starr [col-star_c];
		18: flag <= stars [col-star_c];
		19: flag <= start [col-star_c];
		
        20: flag <= staru [col-star_c];
		21: flag <= starv [col-star_c];
		22: flag <= starw [col-star_c];
		23: flag <= starx [col-star_c];
		24: flag <= stary [col-star_c];
		25: flag <= starz [col-star_c];
		26: flag <= staraa [col-star_c];
		27: flag <= starab [col-star_c];
		28: flag <= starac [col-star_c];
		29: flag <= starad [col-star_c];
		
        30: flag <= starae [col-star_c];
		31: flag <= staraf [col-star_c];
		32: flag <= starag [col-star_c];
		33: flag <= starah [col-star_c];
        34: flag <= starai [col-star_c];
		35: flag <= staraj [col-star_c];
		36: flag <= starak [col-star_c];
		37: flag <= staral [col-star_c];
		38: flag <= staram [col-star_c];
		39: flag <= staran [col-star_c];
		
        40: flag <= starao [col-star_c];
		41: flag <= starap [col-star_c];
		42: flag <= staraq [col-star_c];
		43: flag <= starar [col-star_c];
		44: flag <= staras [col-star_c];
		45: flag <= starat [col-star_c];
		46: flag <= starau [col-star_c];
		47: flag <= starav [col-star_c];
		48: flag <= staraw [col-star_c];
		49: flag <= starax [col-star_c];
		
        50: flag <= staray [col-star_c];
        51: flag <= staraz [col-star_c];
		52: flag <= starba [col-star_c];
		53: flag <= starbb [col-star_c];
		54: flag <= starbc [col-star_c];
        55: flag <= starbd [col-star_c];
		56: flag <= starbe [col-star_c];
		57: flag <= starbf [col-star_c];
		58: flag <= starbg [col-star_c];
		59: flag <= starbh [col-star_c];
		
        60: flag <= starbi [col-star_c];
		61: flag <= starbj [col-star_c];
		62: flag <= starbk [col-star_c];
		63: flag <= starbl [col-star_c];
		64: flag <= starbm [col-star_c];
		65: flag <= starbn [col-star_c];
		66: flag <= starbo [col-star_c];
		67: flag <= starbp [col-star_c];
		68: flag <= starbq [col-star_c];
        69: flag <= starbr [col-star_c];
		
        70: flag <= starbs [col-star_c];
		71: flag <= starbt [col-star_c];
		72: flag <= starbu [col-star_c];
		73: flag <= starbv [col-star_c];
		74: flag <= starbw [col-star_c];
		75: flag <= starbx [col-star_c];
		76: flag <= starby [col-star_c];
		77: flag <= starbz [col-star_c];
		78: flag <= starca [col-star_c];
		79: flag <= starcb [col-star_c];
		
        80: flag <= starcc [col-star_c];
		81: flag <= starcd [col-star_c];
		82: flag <= starce [col-star_c];
		83: flag <= starcf [col-star_c];
		84: flag <= starcg [col-star_c];
		85: flag <= starch [col-star_c];
        86: flag <= starci [col-star_c];
		87: flag <= starcj [col-star_c];
		88: flag <= starck [col-star_c];
		89: flag <= starcl [col-star_c];
		
        90: flag <= starcm [col-star_c];
		91: flag <= starcn [col-star_c];
		92: flag <= starco [col-star_c];
		93: flag <= starcp [col-star_c];
		94: flag <= starcq [col-star_c];
		95: flag <= starcr [col-star_c];
		
		
		//96x103
		default:flag<=0;
	endcase
end

//star_en
always@(posedge clk) begin
	if(flag) begin
		if(blink==0) star_en<=3'b000;//black
		else if(blink==1) star_en<=3'b100;//red
		else if(blink==2) star_en<=3'b111;//white
		else star_en<=3'b000;//black
	end
	else star_en<=3'b001;//blue
end

endmodule
