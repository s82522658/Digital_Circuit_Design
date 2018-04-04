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
reg mode_t;
reg [3:0]count;
reg [3:0]count2;


//---------------------------------------------------------------------
// PARAMETER DECLARATION
//---------------------------------------------------------------------
parameter IDLE=2'd0;
parameter IN=2'd1;
parameter OUT=2'd2;


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
				if(op==2&&in_valid1) next_state<=OUT;
				else next_state<=current_state;
			end
			OUT:begin
				if(count2==9) next_state<=IDLE;
				else next_state<=current_state;
			end
			default: next_state<=IDLE;
		endcase
	end
end
//---------------------------------------------------------------------
//   Design Description
//---------------------------------------------------------------------

//out_valid
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) out_valid<=0;
	else if(in_valid1&&op==2||current_state==OUT) out_valid<=1;
	else out_valid<=0; 

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
	else count<=0;
end
//count2
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) count2<=0;
	else if(op==2&&in_valid1||current_state==OUT) count2<=count2+1;
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
		out<=0;
	end
	
	else if(in_valid1) begin
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
			default: begin
				if(box[0]>=box[0]&&box[0]>=box[1]&&box[0]>=box[2]&&box[0]>=box[3]
				&&box[0]>=box[4]&&box[0]>=box[5]&&box[0]>=box[6]&&box[0]>=box[7]&&box[0]>=box[8]&&box[0]>=box[9]) begin
					out<=box[0];
					box[0]<=0;
				end
				//1
				else if(box[1]>=box[0]&&box[1]>=box[1]&&box[1]>=box[2]&&box[1]>=box[3]
				&&box[1]>=box[4]&&box[1]>=box[5]&&box[1]>=box[6]&&box[1]>=box[7]&&box[1]>=box[8]&&box[1]>=box[9]) begin
					out<=box[1];
					box[1]<=0;
				end
				//2
				else if(box[2]>=box[0]&&box[2]>=box[1]&&box[2]>=box[2]&&box[2]>=box[3]
				&&box[2]>=box[4]&&box[2]>=box[5]&&box[2]>=box[6]&&box[2]>=box[7]&&box[2]>=box[8]&&box[2]>=box[9]) begin
					out<=box[2];
					box[2]<=0;
				end
				//3
				else if(box[3]>=box[0]&&box[3]>=box[1]&&box[3]>=box[2]&&box[3]>=box[3]
				&&box[3]>=box[4]&&box[3]>=box[5]&&box[3]>=box[6]&&box[3]>=box[7]&&box[3]>=box[8]&&box[3]>=box[9]) begin
					out<=box[3];
					box[3]<=0;
				end
				//4
				else if(box[4]>=box[0]&&box[4]>=box[1]&&box[4]>=box[2]&&box[4]>=box[3]
				&&box[4]>=box[4]&&box[4]>=box[5]&&box[4]>=box[6]&&box[4]>=box[7]&&box[4]>=box[8]&&box[4]>=box[9]) begin
					out<=box[4];
					box[4]<=0;
				end
				//5
				else if(box[5]>=box[0]&&box[5]>=box[1]&&box[5]>=box[2]&&box[5]>=box[3]
				&&box[5]>=box[4]&&box[5]>=box[5]&&box[5]>=box[6]&&box[5]>=box[7]&&box[5]>=box[8]&&box[5]>=box[9]) begin
					out<=box[5];
					box[5]<=0;
				end
				//6
				else if(box[6]>=box[0]&&box[6]>=box[1]&&box[6]>=box[2]&&box[6]>=box[3]
				&&box[6]>=box[4]&&box[6]>=box[5]&&box[6]>=box[6]&&box[6]>=box[7]&&box[6]>=box[8]&&box[6]>=box[9]) begin
					out<=box[6];
					box[6]<=0;
				end
				//7
				else if(box[7]>=box[0]&&box[7]>=box[1]&&box[7]>=box[2]&&box[7]>=box[3]
				&&box[7]>=box[4]&&box[7]>=box[5]&&box[7]>=box[6]&&box[7]>=box[7]&&box[7]>=box[8]&&box[7]>=box[9]) begin
					out<=box[7];
					box[7]<=0;
				end
				//8
				else if(box[8]>=box[0]&&box[8]>=box[1]&&box[8]>=box[2]&&box[8]>=box[3]
				&&box[8]>=box[4]&&box[8]>=box[5]&&box[8]>=box[6]&&box[8]>=box[7]&&box[8]>=box[8]&&box[8]>=box[9]) begin
					out<=box[8];
					box[8]<=0;
				end
				//9
				else if(box[9]>=box[0]&&box[9]>=box[1]&&box[9]>=box[2]&&box[9]>=box[3]
				&&box[9]>=box[4]&&box[9]>=box[5]&&box[9]>=box[6]&&box[9]>=box[7]&&box[9]>=box[8]&&box[9]>=box[9]) begin
					out<=box[9];
					box[9]<=0;
				end
				else out<=0; 
				//$display("after sort1 %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d",box[0],box[1],box[2],box[3],box[4],box[5],box[6],box[7],box[8],box[9]);
			end
		endcase
		//$display("after in %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d",box[0],box[1],box[2],box[3],box[4],box[5],box[6],box[7],box[8],box[9]);
	end	
	else if(current_state==OUT) begin
		if(box[0]>=box[0]&&box[0]>=box[1]&&box[0]>=box[2]&&box[0]>=box[3]
		&&box[0]>=box[4]&&box[0]>=box[5]&&box[0]>=box[6]&&box[0]>=box[7]&&box[0]>=box[8]&&box[0]>=box[9]) begin
			out<=box[0];
			box[0]<=0;
		end
		//1
		else if(box[1]>=box[0]&&box[1]>=box[1]&&box[1]>=box[2]&&box[1]>=box[3]
		&&box[1]>=box[4]&&box[1]>=box[5]&&box[1]>=box[6]&&box[1]>=box[7]&&box[1]>=box[8]&&box[1]>=box[9]) begin
			out<=box[1];
			box[1]<=0;
		end
		//2
		else if(box[2]>=box[0]&&box[2]>=box[1]&&box[2]>=box[2]&&box[2]>=box[3]
		&&box[2]>=box[4]&&box[2]>=box[5]&&box[2]>=box[6]&&box[2]>=box[7]&&box[2]>=box[8]&&box[2]>=box[9]) begin
			out<=box[2];
			box[2]<=0;
		end
		//3
		else if(box[3]>=box[0]&&box[3]>=box[1]&&box[3]>=box[2]&&box[3]>=box[3]
		&&box[3]>=box[4]&&box[3]>=box[5]&&box[3]>=box[6]&&box[3]>=box[7]&&box[3]>=box[8]&&box[3]>=box[9]) begin
			out<=box[3];
			box[3]<=0;
		end
		//4
		else if(box[4]>=box[0]&&box[4]>=box[1]&&box[4]>=box[2]&&box[4]>=box[3]
		&&box[4]>=box[4]&&box[4]>=box[5]&&box[4]>=box[6]&&box[4]>=box[7]&&box[4]>=box[8]&&box[4]>=box[9]) begin
			out<=box[4];
			box[4]<=0;
		end
		//5
		else if(box[5]>=box[0]&&box[5]>=box[1]&&box[5]>=box[2]&&box[5]>=box[3]
		&&box[5]>=box[4]&&box[5]>=box[5]&&box[5]>=box[6]&&box[5]>=box[7]&&box[5]>=box[8]&&box[5]>=box[9]) begin
			out<=box[5];
			box[5]<=0;
		end
		//6
		else if(box[6]>=box[0]&&box[6]>=box[1]&&box[6]>=box[2]&&box[6]>=box[3]
		&&box[6]>=box[4]&&box[6]>=box[5]&&box[6]>=box[6]&&box[6]>=box[7]&&box[6]>=box[8]&&box[6]>=box[9]) begin
			out<=box[6];
			box[6]<=0;
		end
		//7
		else if(box[7]>=box[0]&&box[7]>=box[1]&&box[7]>=box[2]&&box[7]>=box[3]
		&&box[7]>=box[4]&&box[7]>=box[5]&&box[7]>=box[6]&&box[7]>=box[7]&&box[7]>=box[8]&&box[7]>=box[9]) begin
			out<=box[7];
			box[7]<=0;
		end
		//8
		else if(box[8]>=box[0]&&box[8]>=box[1]&&box[8]>=box[2]&&box[8]>=box[3]
		&&box[8]>=box[4]&&box[8]>=box[5]&&box[8]>=box[6]&&box[8]>=box[7]&&box[8]>=box[8]&&box[8]>=box[9]) begin
			out<=box[8];
			box[8]<=0;
		end
		//9
		else if(box[9]>=box[0]&&box[9]>=box[1]&&box[9]>=box[2]&&box[9]>=box[3]
		&&box[9]>=box[4]&&box[9]>=box[5]&&box[9]>=box[6]&&box[9]>=box[7]&&box[9]>=box[8]&&box[9]>=box[9]) begin
			out<=box[9];
			box[9]<=0;
		end
		else out<=0;
		//$display("after sort %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d, %6d",box[0],box[1],box[2],box[3],box[4],box[5],box[6],box[7],box[8],box[9]);
		
	end

	else if(current_state==IDLE) begin
		box[0]<=0; box[1]<=0; box[2]<=0;
		box[3]<=0; box[4]<=0; box[5]<=0;
		box[6]<=0; box[7]<=0; box[8]<=0; box[9]<=0;
		out<=0;
	end
	else begin
			box[0]<=box[0]; box[1]<=box[1]; box[2]<=box[2];
			box[3]<=box[3]; box[4]<=box[4]; box[5]<=box[5];
			box[6]<=box[6]; box[7]<=box[7]; box[8]<=box[8]; box[9]<=box[9];
			out<=0;
		end
	
end


endmodule
             