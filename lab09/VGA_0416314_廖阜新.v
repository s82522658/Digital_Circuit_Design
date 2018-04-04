`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:50 12/23/2016 
// Design Name: 
// Module Name:    VGA_0416314 
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
module Xmas(
	VGA_RED,
	VGA_BLUE,
	VGA_GREEN,
	VGA_HSYNC,
	VGA_VSYNC,
	clk,
	rst
);

input rst,clk;
output VGA_RED,VGA_BLUE,VGA_GREEN,VGA_VSYNC,VGA_HSYNC;


wire [2:0]tree;
wire [2:0]sstar[0:6];
wire [2:0]bstar[0:1];
wire [2:0]snow [0:3];
wire visible;
wire [10:0] col,row;
//wire [13:0] shape;

reg blink;
reg [1:0] b_blink,star_cnt;
reg [2:0] color;
reg [25:0] counter;
reg [10:0] pixel_col,pixel_row,snow_r0,snow_r1,snow_r2,snow_r3,star_r0,star_c1;


parameter H_fp=919;
parameter H_bp=104;
parameter H_pw=1039;
parameter H_disp=904;
parameter V_fp=659;
parameter V_bp=23;
parameter V_pw=665;
parameter V_disp=623;

assign VGA_RED = color[2];
assign VGA_GREEN = color[1];
assign VGA_BLUE = color[0];
assign VGA_HSYNC=~(pixel_col >= H_fp & pixel_col < H_pw);
assign VGA_VSYNC=~(pixel_row >= V_fp & pixel_row < V_pw);
assign visible=( pixel_col>=H_bp & pixel_col<H_disp & pixel_row>=V_bp & pixel_row<V_disp );//timing of display 
assign col=pixel_col - H_bp;
assign row=pixel_row - V_bp;

//////include module//////
TREE T1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .tree_en(tree)
    );

sSTAR sSTAR0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(58),
	.star_c(388),
    .blink(blink),
	.star_en(sstar[0])
    );

sSTAR sSTAR1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(150),
	.star_c(313),
    .blink(blink),
	.star_en(sstar[1])
    );

sSTAR sSTAR2 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(150),
	.star_c(463),
    .blink(blink),
	.star_en(sstar[2])
    );


sSTAR sSTAR3 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(275),
	.star_c(263),
    .blink(blink),
	.star_en(sstar[3])
    );


sSTAR sSTAR4 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(275),
	.star_c(513),
    .blink(blink),
	.star_en(sstar[4])
    );

sSTAR sSTAR5 (
	.clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(450),
	.star_c(213),
    .blink(blink),
	.star_en(sstar[5])
    );

sSTAR sSTAR6 (
	.clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(450),
	.star_c(563),
    .blink(blink), 
	.star_en(sstar[6])
    );

bSTAR bSTAR0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .blink(b_blink), 
	.star_c(59),
	.star_r(star_r0),
	.star_en(bstar[0])
    );

bSTAR bSTAR1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .blink(b_blink), 
	.star_c(star_c1),
	.star_r(27),
	.star_en(bstar[1])
    );

SNOW snow0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r0), 
	.snow_c(48),
    .snow_en(snow[0])
    );

SNOW snow1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r1), 
	.snow_c(148),
    .snow_en(snow[1])
    );

SNOW snow2 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r2), 
	.snow_c(628),
    .snow_en(snow[2])
    );

SNOW snow3 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r3), 
	.snow_c(728),
    .snow_en(snow[3])
    );

//////////////////////////
/*
//////include module//////
TREE T1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .tree_en(shape[0])
    );

sSTAR sSTAR0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(58),
	.star_c(388),
	.star_en(shape[1])
    );

sSTAR sSTAR1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(150),
	.star_c(313),
	.star_en(shape[2])
    );

sSTAR sSTAR2 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(150),
	.star_c(463),
	.star_en(shape[3])
    );


sSTAR sSTAR3 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(275),
	.star_c(263),
	.star_en(shape[4])
    );


sSTAR sSTAR4 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(275),
	.star_c(513),
	.star_en(shape[5])
    );

sSTAR sSTAR5 (
	.clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(450),
	.star_c(213),
	.star_en(shape[6])
    );

sSTAR sSTAR6 (
	.clk(clk), 
    .col(col), 
    .row(row), 
    .star_r(450),
	.star_c(563),
	.star_en(shape[7])
    );

bSTAR bSTAR0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
	.star_c(59),
	.star_r(star_r0),
	.star_en(shape[8])
    );

bSTAR bSTAR1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
	.star_c(star_c1),
	.star_r(27),
	.star_en(shape[9])
    );

SNOW snow0 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r0), 
	.snow_c(48),
    .snow_en(shape[10])
    );

SNOW snow1 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r1), 
	.snow_c(148),
    .snow_en(shape[11])
    );

SNOW snow2 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r2), 
	.snow_c(628),
    .snow_en(shape[12])
    );

SNOW snow3 (
    .clk(clk), 
    .col(col), 
    .row(row), 
    .snow_r(snow_r3), 
	.snow_c(728),
    .snow_en(shape[13])
    );

//////////////////////////*/
//pixel_col
always@(posedge clk or posedge rst) begin
	if(rst) pixel_col<=0;
	else if(pixel_col==H_pw) pixel_col<=0;
	else pixel_col<=pixel_col+1;
end

//pixel_row
always@(posedge clk or posedge rst) begin
	if(rst) pixel_row<=0;
	else if(pixel_col==H_pw) pixel_row<=pixel_row+1;
	else if(pixel_row==V_pw)pixel_row<=0;
	else pixel_row<=pixel_row;
end

//counter
always@(posedge clk or posedge rst) begin
	if(rst) counter<=0;
	else if(counter == 25000000) counter<=0;
	else counter<=counter+1;
end

//blink
always@(posedge clk or posedge rst) begin
	if(rst) blink<=0;
	else if(counter == 25000000) blink<=~blink;
	else blink<=blink;
end

//b_blink
always@(posedge clk or posedge rst) begin
	if(rst) b_blink<=0;
	else if(counter == 25000000) begin
		case(b_blink)
			0:b_blink<=1;
			1:b_blink<=2;
			2:b_blink<=0;
			default:b_blink<=0;
		endcase
	end	
	else b_blink<=b_blink;
end
//star_cnt
always@(posedge clk or posedge rst) begin
	if(rst) star_cnt<=0;
	else if(counter==25000000) star_cnt<=star_cnt+1;
	else star_cnt<=star_cnt;
end	
//star_r0
always@(posedge clk or posedge rst) begin
	if(rst) star_r0<=27;
	else if(counter==25000000) begin
		case(star_cnt)
			0:star_r0<=star_r0-5;
			1:star_r0<=star_r0+5;
			2:star_r0<=star_r0+5;
			3:star_r0<=star_r0-5;
		endcase
	end	
	else star_r0<=star_r0;
end
//star_c1
always@(posedge clk or posedge rst) begin
	if(rst) star_c1<=639;
	else if(counter==25000000) begin
		case(star_cnt)
			0:star_c1<=star_c1-5;
			1:star_c1<=star_c1+5;
			2:star_c1<=star_c1+5;
			3:star_c1<=star_c1-5;
		endcase
	end	
	else star_c1<=star_c1;
end
//snow_r0
always@(posedge clk or posedge rst) begin
	if(rst) snow_r0<=350;
	else if(counter==25000000) snow_r0<=snow_r0+5;
	else if(snow_r0>=600) snow_r0<=350;
	else snow_r0<=snow_r0;
end
//snow_r1
always@(posedge clk or posedge rst) begin
	if(rst) snow_r1<=150;
	else if(counter==25000000) snow_r1<=snow_r1+5;
	else if(snow_r1>=600) snow_r1<=150;
	else snow_r1<=snow_r1;
end
//snow_r2
always@(posedge clk or posedge rst) begin
	if(rst) snow_r2<=450;
	else if(counter==25000000) snow_r2<=snow_r2+5;
	else if(snow_r2>=600) snow_r2<=450;
	else snow_r2<=snow_r2;
end
//snow_r3
always@(posedge clk or posedge rst) begin
	if(rst) snow_r3<=250;
	else if(counter==25000000) snow_r3<=snow_r3+5;
	else if(snow_r3>=600) snow_r3<=250;
	else snow_r3<=snow_r3;
end

//color
always@(posedge clk or posedge rst)begin
	if(rst) color<=3'b000;
	else if(visible) begin
        if( row >= star_r0 & row < star_r0+96 & col >= 59 & col <= 161 ) color<=bstar[0];
        else if( row >= 27 & row < 123 & col >= star_c1 & col <= star_c1+102 )color<=bstar[1];
        else if( row >= 58 & row < 75 & col >= 388 & col <= 412 ) color <= sstar[0];
        else if( row >= 150 & row < 167 & col >= 313 & col <= 337 ) color <= sstar[1];
        else if( row >= 150 & row < 167 & col >= 463 & col <= 487 ) color <= sstar[2];
        else if( row >= 275 & row < 292 & col >= 263 & col <= 287 ) color <= sstar[3];
        else if( row >= 275 & row < 292 & col >= 513 & col <= 537 ) color <= sstar[4];
        else if( row >= 450 & row < 467 & col >= 213 & col <= 237 ) color <= sstar[5];
        else if( row >= 450 & row < 467 & col >= 563 & col <= 587 ) color <= sstar[6];
        else if( row >= snow_r0 & row < snow_r0  + 17 & col >= 48 & col <= 72 ) color<=snow[0];
        else if( row >= snow_r1 & row < snow_r1  + 17 & col >= 148 & col <= 172 ) color<=snow[1];
        else if( row >= snow_r2 & row < snow_r2  + 17 & col >= 628 & col <= 652 ) color<=snow[2];
        else if( row >= snow_r3 & row < snow_r3  + 17 & col >= 728 & col <= 752 ) color<=snow[3];
       // else if( row >= 75 & row < 600& col >= 225 & col < 575 )color<= tree;
		else if( row >=75 & row < 150 & col >= 400-(row-75) & col <= 400+(row-75) ) color <= tree;
        else if( row >=150 & row < 275 & col >= 400-(row-150) & col <= 400+(row-150) ) color <= tree;
        else if( row >=275 & row < 450 & col >= 400-(row-275) & col <= 400+(row-275) ) color <= tree;
        else if ( row >=450 & row < 600 & col >= 365 & col <= 435 ) color <= tree;
        else color<=3'b001;//blue
	end
	else color <= 3'b000;//unvisible->black
end
/*
//color
always@(posedge clk or posedge rst)begin
	if(rst) color<=3'b000;
	else if(visible) begin
		case(shape)
		//tree
			1:begin
				if( row >=75 & row < 150 & col >= 400-(row-75) & col <= 400+(row-75) ) color <= 3'b010;//green
				else if( row >=150 & row < 275 & col >= 400-(row-150) & col <= 400+(row-150) ) color <= 3'b010;//green
				else if( row >=275 & row < 450 & col >= 400-(row-275) & col <= 400+(row-275) ) color <= 3'b010;//green
				else if ( row >=450 & row < 600 & col >= 365 & col <= 435 ) color <= 3'b000;//black
				else color <= 3'b001;//blue
			end
		//7 s_stars
			2,4,8,16,32,64,128:begin
				if(blink) color<=3'b111;//white
				else color<=3'b110;//yellow
			end
		//2 b_stars
			256,512: begin
				if(b_blink==0) color<=3'b000;//black
				else if(b_blink==1) color<=3'b100;//red
				else if(b_blink==2) color<=3'b111;//white
				else color<=3'b000;//black
			end
		//4 snows
			1024,2048,4096,8192:color<=3'b111;//white
			default:color <= 3'b001;//blue
		endcase
	end
	else color <= 3'b000;//unvisible->black
end
*/

endmodule
