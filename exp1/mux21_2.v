`timescale 1ns/10ps  //时间单位/精度

module mux21b(a,b,s,y);
    input a,b,s;
    output reg y;
	 
	 always @ (*)
	 begin
	    if(s==0) y=a;
		 else y=b;
	 end
endmodule


// testbench
module mux21b_tb;

reg a,b,s;
wire y;

mux21b mux21b(
   .a(a),
   .b(b),
   .s(s),
   .y(y)
);

initial begin

     a<=0;b<=0;s<=0;
#10  a<=0;b<=0;s<=1;
#10  a<=0;b<=1;s<=0;  
#10  a<=0;b<=1;s<=1;  
#10  a<=1;b<=0;s<=0;  
#10  a<=1;b<=0;s<=1;  
#10  a<=1;b<=1;s<=0;  
#10  a<=1;b<=1;s<=1;      
    

end

endmodule
