module crossover(
	 input clk,
	 output reg clk_1s
	 );

   //add your code here
	
	reg [24:0] count_clk;
	
	initial
		clk_1s = 1;
	
	always @(posedge clk)
	begin
		if(count_clk == 5499999)
 		begin
			count_clk <=0;
			clk_1s <= ~clk_1s;
		end
		else
			count_clk <= count_clk + 1;
	end


endmodule 