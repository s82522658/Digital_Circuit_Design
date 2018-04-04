module ALU_con(OUT,A,B,mode);

input [3:0]A,B;
input [1:0]mode;
output  [7:0]OUT;

assign OUT = (mode == 0)? A+B
	:(mode==1)? A&B
	:(mode==2)? (A>B)? 1:0
	: A>>B ;


endmodule