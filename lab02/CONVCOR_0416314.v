module CONVCOR( clk , rst_n , in_valid , in_a, in_b, in_mode, out_valid , out);

input clk , rst_n , in_valid , in_mode; 
input [15:0]in_a, in_b;
output reg out_valid;
output reg signed[35:0]out;
reg signed [7:0]a_r1;
reg signed [7:0]a_c1;
reg signed [7:0]b_r1;
reg signed [7:0]b_c1;
reg signed [7:0]a_r2;
reg signed [7:0]a_c2;
reg signed [7:0]b_r2;
reg signed [7:0]b_c2;
reg signed [7:0]a_r3;
reg signed [7:0]a_c3;
reg signed [7:0]b_r3;
reg signed [7:0]b_c3;
reg [3:0]count;
reg mode;


always@(posedge clk)
begin

	if(rst_n==0) 
	begin
		a_r1<=0; a_r2<=0; a_r3<=0;
		a_c1<=0; a_c2<=0; a_c3<=0;
		b_r1<=0; b_r2<=0; b_r3<=0;
		b_c1<=0; b_c2<=0; b_c3<=0;
		out<=0;
		count<=0;
		out_valid<=0;
	end
//get input	
	if(in_valid==1)
	begin
		count<=count+1;
		case(count)
			4'b0000:
			begin 
			a_r1<=in_a[15:8];
			a_c1<=in_a[7:0];
			b_r1<=in_b[15:8];
			b_c1<=in_b[7:0];
			mode<=in_mode;
			end
			4'b0001:
			begin 
			a_r2<=in_a[15:8];
			a_c2<=in_a[7:0];
			b_r2<=in_b[15:8];
			b_c2<=in_b[7:0];
			end
			4'b0010:
			begin 
			a_r3<=in_a[15:8];
			a_c3<=in_a[7:0];
			b_r3<=in_b[15:8];
			b_c3<=in_b[7:0];
			end
		endcase 
	end

	
//output	
	if(count>=3)
	begin
		count<=count+1;
		if(mode==0)
		begin
			case(count)
			4'b0011:
			begin 
			out[35:18]<=(a_r1*b_r1)-(a_c1*b_c1);
			out[17:0]<=(a_r1*b_c1)+(a_c1*b_r1);
			out_valid<=1;
			end
			4'b0100:
			begin 
			out[35:18]<=(a_r1*b_r2)-(a_c1*b_c2)+(a_r2*b_r1)-(a_c2*b_c1);
			out[17:0]<=(a_r1*b_c2)+(a_c1*b_r2)+(a_r2*b_c1)+(a_c2*b_r1);
			end
			4'b0101:
			begin 
			out[35:18]<=(a_r1*b_r3)-(a_c1*b_c3)+(a_r3*b_r1)-(a_c3*b_c1)+(a_r2*b_r2)-(a_c2*b_c2);
			out[17:0]<=(a_r1*b_c3)+(a_c1*b_r3)+(a_r3*b_c1)+(a_c3*b_r1)+(a_r2*b_c2)+(a_c2*b_r2);
			end
			4'b0110:
			begin
			out[35:18]<=(a_r3*b_r2)-(a_c3*b_c2)+(a_r2*b_r3)-(a_c2*b_c3);
			out[17:0]<=(a_r3*b_c2)+(a_c3*b_r2)+(a_r2*b_c3)+(a_c2*b_r3);
			end
			4'b0111:
			begin 
			out[35:18]<=(a_r3*b_r3)-(a_c3*b_c3);
			out[17:0]<=(a_r3*b_c3)+(a_c3*b_r3);
			end
			4'b1000:
			begin 
			out<=0;
			out_valid<=0;
			count<=0;
			end
			endcase 
		end
		
		else if(mode==1) 
		begin
			case(count)
			4'b0011:
			begin
			out[35:18]<=(a_r1*b_r1)+(a_c1*b_c1)+(a_r2*b_r2)+(a_c2*b_c2)+(a_r3*b_r3)+(a_c3*b_c3);
			out[17:0]<=-(a_r1*b_c1)+(a_c1*b_r1)-(a_r2*b_c2)+(a_c2*b_r2)-(a_r3*b_c3)+(a_c3*b_r3);
			out_valid<=1;
			end
			4'b0100:
			begin 
			out<=0;
			out_valid<=0;
			count<=0;
			end
			endcase 
			
		end

	
	end

end

endmodule