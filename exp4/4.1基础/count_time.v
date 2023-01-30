module counter(
	input  clk,
	input  en,//使能端
	input  rst,//重置位
	input  [3:0] cnt_limit,
	input  [3:0] cnt_limit2,
	
	output reg [3:0] Q,
	output reg [3:0] Q2,
	output reg pause
	);

// add your code here

  
always @ (posedge clk)
	begin
	 if (pause) 
	   pause<=0;
	 if(rst) 
	   begin
		Q<=0;
		Q2<=0;
		end 
    if (en)
	  begin
		  if(rst) 
			  begin
			  Q<=0;
			  Q2<=0;
			  end 
		  else 
			  begin
			  Q<=Q+1;
			  if(Q==cnt_limit-1)
				begin
				Q<=0;
				Q2<=Q2+1;
				if(Q2==cnt_limit-1)
				  begin
				  Q2<=0;
				  pause<=1;
				  end
				end
			  end
	   end
	end
endmodule
