`timescale 1ns/10ps  //时间单位/精度

 module mux41(
	input [1:0] X0,
	input [1:0] X1,
	input [1:0] X2,
	input [1:0] X3,
	input [1:0] Y,
	output wire [1:0] F
	);

//add your code here

assign F[0]=(~Y[0]&~Y[1]&X0[0])|(Y[0]&~Y[1]&X1[0])|(~Y[0]&Y[1]&X2[0])|(Y[0]&Y[1]&X3[0]);
assign F[1]=(~Y[0]&~Y[1]&X0[1])|(Y[0]&~Y[1]&X1[1])|(~Y[0]&Y[1]&X2[1])|(Y[0]&Y[1]&X3[1]);

endmodule

// testbench
module mux41_tb;

reg [1:0] X0;
reg [1:0] X1;
reg [1:0] X2;
reg [1:0] X3;
reg [1:0] Y;
wire [1:0] F;

mux41 mux41(
   .X0(X0),
	.X1(X1),
	.X2(X2),
	.X3(X3),
	.Y(Y),
	.F(F)
);

initial begin

    X0=0; X1=1; X2=2; X3=3; Y=0;
#10 X0=0; X1=1; X2=2; X3=3; Y=1;
#10 X0=0; X1=1; X2=2; X3=3; Y=2;
#10 X0=0; X1=1; X2=2; X3=3; Y=3;
#10 X0=0; X1=1; X2=2; X3=0; Y=3;
#10 X0=0; X1=1; X2=3; X3=0; Y=2;   

end

endmodule


