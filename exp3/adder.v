module adder(
	input  [3:0] A,
	input  [3:0] B,
	input  addsub,
	output [3:0] F,
	output cf,
	output zero,
	output of
	);

// add your code here
wire [3:0]t;
wire m;
assign t=(   { 4 {addsub} }  ^B);
assign { m, F } = A + t+addsub;
assign cf=m^addsub;
assign of= (A[3]==t[3]) && (F[3]!=A[3]) ;
assign zero=~( | F);



endmodule