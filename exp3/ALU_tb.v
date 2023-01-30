//testbench
`timescale 1ns/10ps
module ALU_tb;

reg [3:0] A;
reg [3:0] B;
reg [2:0] ALUctr;
wire [3:0] F;
wire cf;
wire zero;
wire of;

ALU ALU( 
   .A(A),
   .B(B),
	.ALUctr(ALUctr),
	.F(F),
	.cf(cf),
	.zero(zero),
	.of(of)
);

initial begin
    A=4'b0000; B=4'b0111; ALUctr=3;
#10 A=4'b0000; B=4'b0111; ALUctr=3;
#10 A=4'b1111; B=4'b1000; ALUctr=3;
#10 A=4'b1111; B=4'b0111; ALUctr=3;
#10 A=4'b1000; B=4'b1000; ALUctr=3;
#10 A=4'b1000; B=4'b1000; ALUctr=3;
#10 A=4'b1111; B=4'b0000; ALUctr=3;
#10 A=4'b1111; B=4'b1000; ALUctr=3;
#10 A=4'b0101; B=4'b1010; ALUctr=3;
#10 A=4'b0101; B=4'b1010; ALUctr=3;
#10 A=4'b0100; B=4'b1110; ALUctr=3;
#10 A=4'b0101; B=4'b1010; ALUctr=3;
#10 A=4'b0101; B=4'b1111; ALUctr=3;
#10 A=4'b0101; B=4'b1111; ALUctr=3;
#10 A=4'b1100; B=4'b1111; ALUctr=3;
#10 A=4'b1111; B=4'b1111; ALUctr=3;
#10 A=4'b1000; B=4'b1111; ALUctr=3;
#10 A=4'b0000; B=4'b1111; ALUctr=3;
#10 A=4'b1111; B=4'b1000; ALUctr=3;
#10 A=4'b0111; B=4'b1000; ALUctr=3;
#10 A=4'b0000; B=4'b1000; ALUctr=3;
#10 A=4'b1111; B=4'b0111; ALUctr=3;
#10 A=4'b1000; B=4'b0111; ALUctr=3;
#10 A=4'b0000; B=4'b0000; ALUctr=3;
#10 A=4'b0001; B=4'b0000; ALUctr=3;
#10 A=4'b0111; B=4'b0011; ALUctr=3;
#10 A=4'b0011; B=4'b0001; ALUctr=3;
#10 A=4'b0011; B=4'b0111; ALUctr=3;
#10 A=4'b0011; B=4'b0001; ALUctr=3;
#10 A=4'b0011; B=4'b0011; ALUctr=3;
#10 A=4'b1000; B=4'b1000; ALUctr=3;
#10 A=4'b1000; B=4'b1100; ALUctr=3;
#10;

end

endmodule

	
	
