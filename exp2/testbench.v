//testbench
`timescale 1ns/10ps  //时间单位/精度


module priority_83encode_tb;

reg [7:0] x;
reg en;
wire [2:0] y;

priority_83encode priority_83encode(
   .x(x),
	.en(en),
	.y(y)
);

initial begin

    en=1;x[7]=1; 
#10 x[7]=0; x[6]=1;
#10 x[7]=0;x[6]=0;x[5]=1;
#10 x=8'b00010000;
#10 x=8'b00001000;
#10 x=8'b00000100;  
#10 x=8'b00000010;  
#10 x=8'b00000001;  
#10 en=0;x=8'b11111111; 
#10;
end

endmodule


