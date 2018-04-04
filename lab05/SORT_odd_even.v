module SORT(
  // Input signals
  clk,
  rst_n,
  in_valid1,
  in_valid2,
  in,
  mode,
  op,
  // Output signals
  out_valid,
  out
);
//---------------------------------------------------------------------
//   INPUT AND OUTPUT DECLARATION
//---------------------------------------------------------------------
input mode,in_valid1,in_valid2,clk,rst_n;
input [4:0] in;
input [1:0] op;
output reg out_valid;
output reg [4:0] out;

reg [1:0] current_state,next_state;
reg [4:0] box [0:9];
reg [4:0] temp;
reg mode_t;
reg [3:0]count;
reg [3:0]count2;
reg [3:0]i;

//---------------------------------------------------------------------
// PARAMETER DECLARATION
//---------------------------------------------------------------------
parameter IDLE=2'd0;
parameter IN=2'd1;
//parameter POP=3'd2;
parameter SORT=2'd2;
parameter OUT=2'd3;

//integer i;
//---------------------------------------------------------------------
//   WIRE AND REG DECLARATION
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//   Finite-State Mechine
//---------------------------------------------------------------------

//current_state
always@(posedge clk or negedge rst_n) begin
	if(rst_n==0) current_state<=IDLE;
	else current_state<=next_state;
end

//next_state
always@(*) begin
	if(rst_n==0) next_state<=IDLE;
	else begin
		case(current_state)
			IDLE:begin
				if(in_valid1||in_valid2) next_state<=IN;
				else next_state<=current_state;
			end
			IN:begin
				if(op==2&&in_valid1) next_state<=SORT;
				else next_state<=current_state;
			end
			SORT:begin
				if(count2==9) next_state<=OUT;
				else next_state<=current_state;
			end
			OUT:begin
				if(count==9) next_state<=IDLE;
				else next_state<=current_state;
			end
			//default: next_state<=IDLE;
		endcase
	end
end
//---------------------------------------------------------------------
//   Design Description
//---------------------------------------------------------------------

//out_valid
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) out_valid<=0;
	else if(count2==9||current_state==OUT) out_valid<=1;
	else out_valid<=0; 

end
//out
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) out<=0;
	else if(count2==9||current_state==OUT) begin
		/*if()begin
		case(i)
			1:begin
				if(box[i]>box[1]&&box[i]>box[2]&&box[i]>box[3]&&box[i]>box[4]&&box[i]>box[5]&&box[i]>box[6]&&box[i]>box[7]&&box[i]>box[8]&&box[i]>box[9]) begin
					out<=box[0];
					box[0]<=0;
				end
			end	
			2:
		endcase
			if
			end
				
		end*/
		out<=box[count];
	end
	else out<=0;
end
//count
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) count<=0;
	else if(in_valid1) begin
			case(op)
				2'd0:begin
					if(!mode_t) count<=count-1;
					else count<=count-1;
				end
				2'd1:count<=count+1;
				default: count<=count;
			endcase
		end	
	else if(current_state==IN) count<=count;
	else if(count2==9||current_state==OUT) count<=count+1;
	else count<=0;
end
//count2
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) count2<=0;
	else if(current_state==SORT) count2<=count2+1;
	else count2<=0;
end

//mode_t
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) mode_t<=0;
	else if(in_valid2) mode_t<=mode;
	else mode_t<=mode_t;
end

//box 0~9
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		box[0]<=0; box[1]<=0; box[2]<=0;
		box[3]<=0; box[4]<=0; box[5]<=0;
		box[6]<=0; box[7]<=0; box[8]<=0; box[9]<=0;
	end
	else begin
		if(in_valid1) begin
			case(op)
				2'd0:begin
					if(!mode_t)	box[count-1]<=0;//stack
					else begin//queue
						box[0]<=box[1]; box[1]<=box[2]; box[2]<=box[3];
						box[3]<=box[4]; box[4]<=box[5]; box[5]<=box[6];
						box[6]<=box[7]; box[7]<=box[8]; box[8]<=box[9];
						box[9]<=0;
					end
				end
				2'd1:box[count]<=in;
				default:begin
					box[0]<=box[0]; box[1]<=box[1]; box[2]<=box[2];
					box[3]<=box[3]; box[4]<=box[4]; box[5]<=box[5];
					box[6]<=box[6]; box[7]<=box[7]; box[8]<=box[8]; box[9]<=box[9];
				end
			endcase
			//$display("after in %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d",box[0],box[1],box[2],box[3],box[4],box[5],box[6],box[7],box[8],box[9]);
		end	
		else if(current_state==SORT) begin
			if(count2<10) begin
				if(count2%2==1)begin
					for(i=1;i<9;i=i+2) begin
						if(box[i]<box[i+1]) begin
							box[i]<=box[i+1];
							box[i+1]<=box[i];
						end
						else box[i]<=box[i];
					end
				end
				else begin
					for(i=0;i<9;i=i+2) begin
						if(box[i]<box[i+1]) begin
							box[i]<=box[i+1];
							box[i+1]<=box[i];
						end
						else box[i]<=box[i];
					end
				end

				//$display("after sorting %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d",box[0],box[1],box[2],box[3],box[4],box[5],box[6],box[7],box[8],box[9]);
			end
			else begin
				box[0]<=box[0]; box[1]<=box[1]; box[2]<=box[2];
				box[3]<=box[3]; box[4]<=box[4]; box[5]<=box[5];
				box[6]<=box[6]; box[7]<=box[7]; box[8]<=box[8]; box[9]<=box[9];
			end	
		end
		else if(current_state==IDLE) begin
			box[0]<=0; box[1]<=0; box[2]<=0;
			box[3]<=0; box[4]<=0; box[5]<=0;
			box[6]<=0; box[7]<=0; box[8]<=0; box[9]<=0;
		end
		else begin
			box[0]<=box[0]; box[1]<=box[1]; box[2]<=box[2];
			box[3]<=box[3]; box[4]<=box[4]; box[5]<=box[5];
			box[6]<=box[6]; box[7]<=box[7]; box[8]<=box[8]; box[9]<=box[9];
		end
	end
end


endmodule
             