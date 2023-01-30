module mux3_1 (
    input [1:0] Y,
    input clk,
	 input [3:0] key,
	 input  en,//使能端
	 input  rst,//重置位
	 
	 output reg twinkle,
	 output reg [3:0] a,
	 output reg [3:0] a2,
	 output reg [3:0] a3,
	 output reg [3:0] a4,
	 output reg [3:0] a5,
	 output reg [3:0] a6
	 
);//0:电子时钟,调整时间；1:调闹铃（在特定时间 LED 闪烁）；2:秒表（提供百分之一秒精度，可以停止重启）.
reg [3:0] Q;
reg [3:0] Q2;
reg [3:0] Q3;
reg [3:0] Q4;
reg [3:0] Q5;
reg [3:0] Q6;

reg [3:0] q;
reg [3:0] q2;
reg [3:0] q3;
reg [3:0] q4;
reg [3:0] q5;
reg [3:0] q6;

reg [3:0] m;
reg [3:0] m2;
reg [3:0] m3;
reg [3:0] m4;
reg [3:0] m5;
reg [3:0] m6;

integer count_clk1=0;
integer count_clk2=0;

always @(posedge clk)
begin
if(count_clk1==24999999*2+1)
   begin
	count_clk1 <=0;
		//闪烁重置
		twinkle<=0;
		//电子时钟
		if(Y==0)
		begin
		 if(rst) 
			begin
			Q<=0;
			Q2<=0;
			Q3<=0;
			Q4<=0;
			Q5<=0;
			Q6<=0;
			end 
		 if (en)
		  begin 
			  Q<=Q+1;
			  if(Q==9)
				begin
				Q<=0;
				Q2<=Q2+1;
				if(Q2==5)
				  begin
				  Q2<=0;
				  Q3<=Q3+1;
				  if(Q3==9)
					 begin
					 Q3<=0;
					 Q4<=Q4+1;
					 if(Q4==5)
						begin
						Q4<=0;
						Q5<=Q5+1;
						if(Q5==3&&Q6==2)
						  begin
						  Q5<=0;
						  Q6<=0;
						  end
						else if(Q5==9)
						  begin
						  Q5<=0;
						  Q6<=Q6+1;
						  end
						end
					 end
				  end
			end
		 end
		//调时
		 if(key[0]==0)
		  begin
		  Q<=Q+1;
		  if(Q==9)
			begin
			Q<=0;
			Q2<=Q2+1;
			if(Q2==5)
			  begin
			  Q2<=0;
			  Q3<=Q3+1;
			  if(Q3==9)
				 begin
				 Q3<=0;
				 Q4<=Q4+1;
				 if(Q4==5)
					begin
					Q4<=0;
					Q5<=Q5+1;
					if(Q5==3&&Q6==2)
					  begin
					  Q5<=0;
					  Q6<=0;
					  end
					else if(Q5==9)
					  begin
					  Q5<=0;
					  Q6<=Q6+1;
					  end
					end
				 end
			  end
			end
		end
		 if(key[1]==0)
		  begin
		Q3<=Q3+1;
		if(Q3==9)
		 begin
		 Q3<=0;
		 Q4<=Q4+1;
		 if(Q4==5)
			begin
			Q4<=0;
			Q5<=Q5+1;
			if(Q5==3&&Q6==2)
			  begin
			  Q5<=0;
			  Q6<=0;
			  end
			else if(Q5==9)
			  begin
			  Q5<=0;
			  Q6<=Q6+1;
			  end
			end
		 end
		end
		 if(key[2]==0)
		  begin
				Q5<=Q5+1;
				if(Q5==3&&Q6==2)
				  begin
				  Q5<=0;
				  Q6<=0;
				  end
				else if(Q5==9)
				  begin
				  Q5<=0;
				  Q6<=Q6+1;
				  end
				end
		//闪烁 
		 if(q==Q &&  q2==Q2 && q3==Q3 && q4==Q4 && q5==Q5 && q6==Q6)
			 twinkle<=1;
		 a<=Q;a2<=Q2;a3<=Q3;a4<=Q4;a5<=Q5;a6<=Q6;
		 end
		
		//调闹钟
	 if(Y==1)
		 begin
	 if(rst) 
	   begin
		q<=0;
		q2<=0;
		q3<=0;
		q4<=0;
		q5<=0;
		q6<=0;
		end 
	 //调时
	 if(key[0]==0)
	  begin
	  q<=q+1;
	  if(q==9)
		begin
		q<=0;
		q2<=q2+1;
		if(q2==5)
		  begin
		  q2<=0;
		  q3<=q3+1;
		  if(q3==9)
			 begin
			 q3<=0;
			 q4<=q4+1;
			 if(q4==5)
				begin
				q4<=0;
				q5<=q5+1;
				if(q5==3&&q6==2)
				  begin
				  q5<=0;
				  q6<=0;
				  end
				else if(q5==9)
				  begin
				  q5<=0;
				  q6<=q6+1;
				  end
				end
			 end
		  end
		end
	end
	 if(key[1]==0)
	  begin
	q3<=q3+1;
	if(q3==9)
	 begin
	 q3<=0;
	 q4<=q4+1;
	 if(q4==5)
		begin
		q4<=0;
		q5<=q5+1;
		if(q5==3&&q6==2)
		  begin
		  q5<=0;
		  q6<=0;
		  end
		else if(q5==9)
		  begin
		  q5<=0;
		  q6<=q6+1;
		  end
		end
	 end
	end
	 if(key[2]==0)
	  begin
			q5<=q5+1;
			if(q5==3&&q6==2)
			  begin
			  q5<=0;
			  q6<=0;
			  end
			else if(q5==9)
			  begin
			  q5<=0;
			  q6<=q6+1;
			  end
			end
    a<=q;a2<=q2;a3<=q3;a4<=q4;a5<=q5;a6<=q6;
	 end
    
   end	 
else
count_clk1 <= count_clk1+1;

if(count_clk2==249999*2+1)
begin
	count_clk2<=0;
	if(Y==2)
	begin
	 if(rst) 
	   begin
		m<=0;
		m2<=0;
		m3<=0;
		m4<=0;
		m5<=0;
		m6<=0;
		end 
    if (en)
	  begin 
		  m<=m+1;
		  if(m==9)
			begin
			m<=0;
			m2<=m2+1;
			if(m2==9)
			  begin
			  m2<=0;
			  m3<=m3+1;
			  if(m3==9)
				 begin
				 m3<=0;
				 m4<=m4+1;
				 if(m4==5)
				   begin
					m4<=0;
					m5<=m5+1;
					if(m5==9)
					begin
					  m5<=0;
					  m6<=m6+1;
					  if(m6==5)
					    begin
						 m6<=0;
						 end
					end	 
					end
				 end
			  end
		end
	 end
	
	
	a<=m;a2<=m2;a3<=m3;a4<=m4;a5<=m5;a6<=m6;
	end
end
else
count_clk2<=count_clk2+1;	
end
endmodule
