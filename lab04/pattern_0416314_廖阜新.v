
`timescale 1ns/10ps
`define CLK_PERIOD  4.0

module PATTERN(
        clk,
        circle1,
        circle2,
        in,
        in_valid,
        rst_n,
        out,
        out_valid
);


output reg             clk;
output reg    [2:0]    circle1;
output reg    [2:0]    circle2;
output reg             rst_n;
output reg             in_valid;
output reg    [4:0]    in;
input            out_valid;
input   [5:0]    out;
reg [5:0] IN [15:0];
reg [2:0] circle_t [1:0];
reg [5:0]temp;


parameter cycle=`CLK_PERIOD;
parameter PATTERN_NUM=5000;
integer i,j,pattern_num,latency,count;

//clk generation

initial begin
        clk = 0;
        forever #cycle clk = ~clk;
end

//initial block
initial begin
	rst_n<=1'b1;
	circle1<= 'dx;
	circle2<= 'dx;
	in_valid<= 'b0;
	in<= 'dx;
	count=0;

//rst_n
	/*#2; 
	rst_n<=1'd0;
	
	#4; 
	rst_n<=1'd1;
	
	check_rst;	
	
	
	@(negedge clk);*/
	
	for(pattern_num=0;pattern_num<PATTERN_NUM;pattern_num=pattern_num+1) begin
	
	#2; 
	rst_n<=1'd0;
	
	#4; 
	rst_n<=1'd1;
	
	check_rst;	
	
	@(negedge clk);
	//give in&&circle&&in_valid
		if(pattern_num==0) begin
			for(i=0;i<16;i=i+1) begin
				if(i==0) begin
					circle_t[0]={$random()}%8;
					circle_t[1]={$random()}%8;
					circle1<=circle_t[0];
					circle2<=circle_t[1];
				end
				else begin
					circle1<= 'dx;
					circle2<= 'dx;
				end
				IN[i] = 31;
				in_valid <= 1'b1;
				in <= IN[i];
				
				check_rst;
				
				@(negedge clk);
				
			end
		end
		else begin
			for(i=0;i<16;i=i+1) begin
				if(i==0) begin
					circle_t[0]={$random()}%8;
					circle_t[1]={$random()}%8;
					circle1<=circle_t[0];
					circle2<=circle_t[1];
				end
				else begin
					circle1<= 'dx;
					circle2<= 'dx;
				end
				IN[i] = {$random()}%32;
				in_valid <= 1'b1;
				in <= IN[i];
				
				check_rst;
				
				@(negedge clk);
				
			end
		end	
		in <= 'dx;
		in_valid <= 1'b0;
		//$display("circle1 is %6d,circle2 is %6d",circle_t[0],circle_t[1]);
		process_out;
		
		wait_out;
		
		//$display("after sorting:%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d",IN[0],IN[1],IN[2],IN[3],IN[4],IN[5],IN[6],IN[7]);
		
		for(i=0;i<8;i=i+1) begin
			if(out_valid!==1'b1) begin
				$display("=================================================");
				$display("  Failed!!  out_valid should be high!             ");
				$display("=================================================");
				$finish;
			end
			if(out !== IN[i]) begin
					$display("");
					$display("=================================================");
					$display("  Failed!!  PATTERN %4d is wrong!                ", pattern_num+1);
					$display("  ans is %d      your ans is %d          ", IN[i],out);
					$display("=================================================");
					$display("");
					repeat(8)@(negedge clk);
					$finish;
			end
			
			@(negedge clk);
		end
		
		$display("");
		$display(" Pass pattern %3d ", pattern_num+1);
		if(out_valid===1'b1) begin
			$display("=================================================");
			$display("  Failed!!  out_valid should be low!     ");
			$display("=================================================");
			$finish;
		end
		
		@(negedge clk);

	end

	@(negedge clk);
	$display ("--------------------------------------------------------------------");
	$display ("                         Congratulations !                          ");
	$display ("                  You have passed all patterns !                    ");
	$display ("                  Your total latency is %6d !                       ", latency);
	$display ("--------------------------------------------------------------------");
	@(negedge clk);
	$finish;

end

	task process_out;begin
		case(circle_t[0])
			1:cir1_1;
			2:cir1_2;
			3:cir1_3;
			4:cir1_4;
			5:cir1_5;
			6:cir1_6;
			7:cir1_7;
		endcase
		case(circle_t[1])
			1:cir2_1;
			2:cir2_2;
			3:cir2_3;
			4:cir2_4;
			5:cir2_5;
			6:cir2_6;
			7:cir2_7;
		endcase	
		@(negedge clk);
		//$display("before addition:%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d",IN[0],IN[1],IN[2],IN[3],IN[4],IN[5],IN[6],IN[7]);
		//$display("before addition:%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d",IN[8],IN[9],IN[10],IN[11],IN[12],IN[13],IN[14],IN[15]);
		IN[0]<=IN[0]+IN[8];
		IN[1]<=IN[1]+IN[9];
		IN[2]<=IN[2]+IN[10];
		IN[3]<=IN[3]+IN[11];
		IN[4]<=IN[4]+IN[12];
		IN[5]<=IN[5]+IN[13];
		IN[6]<=IN[6]+IN[14];
		IN[7]<=IN[7]+IN[15];
		@(negedge clk);
		
		//$display("after addition:%6d,%6d,%6d,%6d,%6d,%6d,%6d,%6d",IN[0],IN[1],IN[2],IN[3],IN[4],IN[5],IN[6],IN[7]);
		
		for(j=0;j<7;j=j+1) begin
			for(i=0;i<7;i=i+1) begin
				if(IN[i]>IN[i+1]) begin
					temp=IN[i+1];
					IN[i+1]=IN[i];
					IN[i]=temp;
				end
			end
		end
		
	end endtask
	task check_rst; begin
		count=count+1;
		if(out !== 'd0 || out_valid !== 1'b0) begin
				
				$display("");
				$display("=================================================");
				$display("  Output should be reset !!!!            ");
				$display("=================================================");
				$display("");
				@(negedge clk);
				$finish;
		end
	end
	endtask
	
	task wait_out;begin
			latency = 0;
			while(!(out_valid === 1'b1)) begin
					if(latency > 100) begin
							$display("");
							$display("=================================================");
							$display("  Latency too more !!!!               ");
							$display("=================================================");
							$display("");
							@(negedge clk);
							$finish;
					end
					latency = latency + 1;
					@(negedge clk);
			end
	end
	endtask
	
	task cir1_1;begin
		for(i=0;i<7;i=i+1) begin
			IN[i+1]<=IN[i];
		end
		IN[0]<=IN[7];
	
	end endtask
	
	task cir1_2;begin
		for(i=0;i<6;i=i+1) begin
			IN[i+2]<=IN[i];
		end
		IN[0]<=IN[6];
		IN[1]<=IN[7];
	end endtask
	
	task cir1_3;begin
		for(i=0;i<5;i=i+1) begin
			IN[i+3]<=IN[i];
		end
		IN[0]<=IN[5];
		IN[1]<=IN[6];
		IN[2]<=IN[7];
	end endtask
	
	task cir1_4;begin
		for(i=0;i<4;i=i+1) begin
			IN[i+4]<=IN[i];
		end
		IN[0]<=IN[4];
		IN[1]<=IN[5];
		IN[2]<=IN[6];
		IN[3]<=IN[7];
	end endtask
	
	task cir1_5;begin
		for(i=0;i<5;i=i+1) begin
			IN[i]<=IN[i+3];
		end
		IN[5]<=IN[0];
		IN[6]<=IN[1];
		IN[7]<=IN[2];
	end endtask
	
	task cir1_6;begin
		for(i=0;i<6;i=i+1) begin
			IN[i]<=IN[i+2];
		end
		IN[6]<=IN[0];
		IN[7]<=IN[1];
	end endtask
	
	task cir1_7;begin
		for(i=0;i<7;i=i+1) begin
			IN[i]<=IN[i+1];
		end
		IN[7]<=IN[0];
	end endtask
	
	task cir2_1;begin
		for(i=8;i<15;i=i+1) begin
			IN[i+1]<=IN[i];
		end
		IN[8]<=IN[15];	
	end endtask
	
	task cir2_2;begin
		for(i=8;i<14;i=i+1) begin
			IN[i+2]<=IN[i];
		end
		IN[8]<=IN[14];
		IN[9]<=IN[15];
	end endtask
	
	task cir2_3;begin
		for(i=8;i<13;i=i+1) begin
			IN[i+3]<=IN[i];
		end
		IN[8]<=IN[13];
		IN[9]<=IN[14];
		IN[10]<=IN[15];
	end endtask
	
	task cir2_4;begin
		for(i=8;i<12;i=i+1) begin
			IN[i+4]<=IN[i];
		end
		IN[8]<=IN[12];
		IN[9]<=IN[13];
		IN[10]<=IN[14];
		IN[11]<=IN[15];
	end endtask
	
	task cir2_5;begin
		for(i=8;i<13;i=i+1) begin
			IN[i]<=IN[i+3];
		end
		IN[13]<=IN[8];
		IN[14]<=IN[9];
		IN[15]<=IN[10];
	end endtask
	
	task cir2_6;begin
		for(i=8;i<14;i=i+1) begin
			IN[i]<=IN[i+2];
		end
		IN[14]<=IN[8];
		IN[15]<=IN[9];
	end endtask
	
	task cir2_7;begin
		for(i=8;i<15;i=i+1) begin
			IN[i]<=IN[i+1];
		end
		IN[15]<=IN[8];
	end endtask
	



endmodule
