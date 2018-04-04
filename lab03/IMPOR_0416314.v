module IMPOR(
        output reg [2:0] out,
        output reg out_valid,
        output reg ready,
        input  [2:0] in,
        input  [2:0] mode,
        input  in_valid,
        input  clk,
        input  rst_n
);



reg [2:0]in_0,in_1,in_2,in_3;
reg [2:0]in_4,in_5,in_6,in_7,in_8;
reg [1:0]current_state,next_state;
reg [3:0]flag;


parameter IDLE=2'd0;
parameter IN=2'd1;
parameter SELECT=2'd2;
parameter OUT=2'd3;


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
			IDLE: begin
				next_state<=IN;
				//else next_state<=current_state;
			end
			IN: begin
				if(flag==8) next_state<=SELECT;
				else next_state<=current_state;
			end
			SELECT: begin
				if(mode==0)next_state<=OUT;
				else next_state<=current_state;
			end
			OUT: begin
				if(flag==0)next_state<=IDLE;
				else next_state<=current_state;	
			end
			//default:next_state<=current_state;
		endcase
	end	
end
//ready
always@(posedge clk or negedge rst_n) begin
	if(rst_n==0) ready<=0;
	else begin
		if(current_state==IN||current_state==SELECT)ready<=1;
		else ready<=0;
	end
end
//flag
always@(posedge clk or negedge rst_n) begin
	if(rst_n==0) flag<=0;
	else if(current_state==IDLE)flag<=0;
	else if(in_valid==1&&flag<9) flag<=flag+1;
	else if(current_state==OUT)flag<=flag-1;
	else flag<=flag;
end

//out_valid
always@(posedge clk or negedge rst_n) begin
	if(rst_n==0) out_valid<=0;
	else if(current_state==OUT&&flag<=8) out_valid<=1;
	else out_valid<=0;
end
//out
always@(posedge clk or negedge  rst_n) begin
	if(rst_n==0) out<=0;
	else if(current_state==OUT&&flag<=8) begin
		case(flag)
			4'd0:out<=in_8;
			4'd1:out<=in_7;
			4'd2:out<=in_6;
			4'd3:out<=in_5;
			4'd4:out<=in_4;
			4'd5:out<=in_3;
			4'd6:out<=in_2;
			4'd7:out<=in_1;
			4'd8:out<=in_0;
		default:out<=0;
		endcase
	end
	else out<=0;
end

//in0
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_0<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd0:in_0<=in;
			default:in_0<=in_0;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_0<=in_2;
			3'd2:in_0<=in_6;
			3'd3:in_0<=in_2;
			3'd4:in_0<=in_6;
			3'd5:if(in_0==7)in_0<=7;else in_0<=in_0+1;
			3'd6:in_0<=in_0;
			3'd7:in_0<=in_0;
			default:in_0<=in_0;
		endcase
	end
	else if(current_state==OUT) in_0<=in_0;
	else in_0<=0;
end
//in1
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_1<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd1:in_1<=in;
			default:in_1<=in_1;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_1<=in_1;
			3'd2:in_1<=in_7;
			3'd3:in_1<=in_5;
			3'd4:in_1<=in_3;
			3'd5:in_1<=in_1;
			3'd6:if(in_1==7)in_1<=7;else in_1<=in_1+1;
			3'd7:in_1<=in_1;
			default:in_1<=in_1;
		endcase
	end
	else if(current_state==OUT) in_1<=in_1;
	else in_1<=0;
end
//in2
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_2<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd2:in_2<=in;
			default:in_2<=in_2;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_2<=in_0;
			3'd2:in_2<=in_8;
			3'd3:in_2<=in_8;
			3'd4:in_2<=in_0;
			3'd5:in_2<=in_2;
			3'd6:in_2<=in_2;
			3'd7:if(in_2==7)in_2<=7;else in_2<=in_2+1;
			default:in_2<=in_2;
		endcase
	end
	else if(current_state==OUT) in_2<=in_2;
	else in_2<=0;
end
//in3
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_3<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd3:in_3<=in;
			default:in_3<=in_3;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_3<=in_5;
			3'd2:in_3<=in_3;
			3'd3:in_3<=in_1;
			3'd4:in_3<=in_7;
			3'd5:if(in_3==7)in_3<=7;else in_3<=in_3+1;
			3'd6:in_3<=in_3;
			3'd7:in_3<=in_3;
			default:in_3<=in_3;
		endcase
	end
	else if(current_state==OUT) in_3<=in_3;
	else in_3<=0;
end
//in4
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_4<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd4:in_4<=in;
			default:in_4<=in_4;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_4<=in_4;
			3'd2:in_4<=in_4;
			3'd3:in_4<=in_4;
			3'd4:in_4<=in_4;
			3'd5:in_4<=in_4;
			3'd6:if(in_4==7)in_4<=7;else in_4<=in_4+1;
			3'd7:in_4<=in_4;
			default:in_4<=in_4;
		endcase
	end
	else if(current_state==OUT) in_4<=in_4;
	else in_4<=0;
end
//in5
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_5<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd5:in_5<=in;
			default:in_5<=in_5;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_5<=in_3;
			3'd2:in_5<=in_5;
			3'd3:in_5<=in_7;
			3'd4:in_5<=in_1;
			3'd5:in_5<=in_5;
			3'd6:in_5<=in_5;
			3'd7:if(in_5==7)in_5<=7;else in_5<=in_5+1;
			default:in_5<=in_5;
		endcase
	end
	else if(current_state==OUT) in_5<=in_5;
	else in_5<=0;
end
//in6
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_6<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd6:in_6<=in;
			default:in_6<=in_6;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_6<=in_8;
			3'd2:in_6<=in_0;
			3'd3:in_6<=in_0;
			3'd4:in_6<=in_8;
			3'd5:if(in_6==7)in_6<=7;else in_6<=in_6+1;
			3'd6:in_6<=in_6;
			3'd7:in_6<=in_6;
			default:in_6<=in_6;
		endcase
	end
	else if(current_state==OUT) in_6<=in_6;
	else in_6<=0;
end
//in7
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_7<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd7:in_7<=in;
			default:in_7<=in_7;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_7<=in_7;
			3'd2:in_7<=in_1;
			3'd3:in_7<=in_3;
			3'd4:in_7<=in_5;
			3'd5:in_7<=in_7;
			3'd6:if(in_7==7)in_7<=7;else in_7<=in_7+1;
			3'd7:in_7<=in_7;
			default:in_7<=in_7;
		endcase
	end
	else if(current_state==OUT) in_7<=in_7;
	else in_7<=0;
end
//in8
always@(posedge clk or negedge rst_n) begin
	if(!rst_n)in_8<=0;
	else if(in_valid&&current_state==IN)begin
		case(flag)
			4'd8:in_8<=in;
			default:in_8<=in_8;
		endcase
	end	
	else if(current_state==SELECT)begin
		case(mode)
			3'd1:in_8<=in_6;
			3'd2:in_8<=in_2;
			3'd3:in_8<=in_6;
			3'd4:in_8<=in_2;
			3'd5:in_8<=in_8;
			3'd6:in_8<=in_8;
			3'd7:if(in_8==7)in_8<=7;else in_8<=in_8+1;
			default:in_8<=in_8;
		endcase
	end
	else if(current_state==OUT) in_8<=in_8;
	else in_8<=0;
end


endmodule