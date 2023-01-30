module lfsr(input  [7:0]  seed,
	input  clk,
	output reg [7:0] dout,
	input in//置位端
	);
//add your code here

always @(posedge clk)
begin
if(in==1)
dout<=seed;
else
   dout<={dout[4]^dout[3]^dout[2]^dout[0],dout[7:1]};
end

endmodule
