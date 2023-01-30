`timescale 1ns/10ps  //时间单位/精度

 module mux41_2(
	input [1:0] X0,
	input [1:0] X1,
	input [1:0] X2,
	input [1:0] X3,
	input [1:0] Y,
	output reg [1:0] F
	);

//add your code here

always @ (*)

   case(Y)
	0:F=X0;
	1:F=X1;
	2:F=X2;
	3:F=X3;
	default:F=1'b0;
	endcase
	



/*   begin 
	if(Y==2'b00)
	F=X0;
	else if(Y==2'b01)
	F=X1;
	else if(Y==2'b10)
	F=X2;
	else 
	F=X3;
	
	end */



endmodule

// testbench
module mux41_2_tb;

reg [1:0] X0;
reg [1:0] X1;
reg [1:0] X2;
reg [1:0] X3;
reg [1:0] Y;
wire [1:0] F;

mux41_2 mux41_2(
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


