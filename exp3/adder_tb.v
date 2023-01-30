//testbench
`timescale 1ns/10ps
module adder_tb;

reg  [3:0] A;
reg  [3:0] B;
reg  addsub;
wire [3:0] F;
wire cf;
wire zero;
wire of;

adder adder(
	.A(A),
	.B(B),
	.addsub(addsub),
	.F(F),
	.cf(cf),
	.zero(zero),
	.of(of)
	
);

initial begin

    A=4'b0000; B=4'b0000; addsub=0;
#10 A=4'b0000; B=4'b0000; addsub=1;
#10 A=4'b0000; B=4'b0111; addsub=0;
#10 A=4'b0001; B=4'b0111; addsub=0;
#10 A=4'b0000; B=4'b1111; addsub=0;
#10 A=4'b0001; B=4'b1111; addsub=0;
#10 A=4'b1111; B=4'b1111; addsub=0;
#10 A=4'b1111; B=4'b1000; addsub=0;
#10 A=4'b0111; B=4'b1000; addsub=0;
#10 A=4'b1111; B=4'b0111; addsub=0;
#10 A=4'b1000; B=4'b1000; addsub=0;
#10 A=4'b0111; B=4'b0111; addsub=0;
#10 A=4'b1001; B=4'b0111; addsub=0;
#10 A=4'b0000; B=4'b0001; addsub=1;
#10 A=4'b0001; B=4'b0000; addsub=1;
#10 A=4'b0010; B=4'b0010; addsub=1;
#10 A=4'b0000; B=4'b0111; addsub=1;
#10 A=4'b0000; B=4'b1000; addsub=1;
#10 A=4'b0001; B=4'b1000; addsub=1;
#10 A=4'b1111; B=4'b1000; addsub=1;
#10 A=4'b1111; B=4'b0111; addsub=1;
#10 A=4'b1000; B=4'b0000; addsub=1;
#10 A=4'b1000; B=4'b0001; addsub=1;
#10 A=4'b1000; B=4'b1111; addsub=1;
#10 A=4'b1000; B=4'b1000; addsub=1;
#10 A=4'b1000; B=4'b1001; addsub=1;
#10 A=4'b0111; B=4'b0111; addsub=1;
#10 A=4'b0111; B=4'b0110; addsub=1;
#10 A=4'b0111; B=4'b1111; addsub=1;
#10 A=4'b0110; B=4'b1100; addsub=1;
#10 A=4'b0110; B=4'b1110; addsub=1;
#10 A=4'b1110; B=4'b0110; addsub=1;
#10;
end

endmodule

	
	
