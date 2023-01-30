`timescale 1ns/10ps  //时间单位/精度

module m_mux21(a,b,s,y);
    input a,b,s;
	 output y;
	 
	 assign y=(~s&a)|(s&b);
	 
endmodule


// testbench
module m_mux21_tb;

reg a,b,s;
wire y;

m_mux21 m_mux21(
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


