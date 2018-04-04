module ALU_pro(OUT,A,B,MODE);

input [3:0]A,B;
input  [1:0]MODE;
output reg [7:0]OUT;

always@(MODE or A or B)
begin
if(MODE==0) OUT=A+B;
else if (MODE ==1) OUT=A&B;
else if (MODE ==2) if(A>B) OUT=1; else OUT=0;
else OUT=A>>B;

end

endmodule