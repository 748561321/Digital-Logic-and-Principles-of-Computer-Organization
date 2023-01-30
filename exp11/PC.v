module PC_(
input [31:0]PC,
input [31:0]imm,
input [31:0]rs1data,
input [2:0]Branch,
input zero,
input less,
output reg [31:0] NextPC,
input reset
);
initial begin

NextPC=0;
end

always @(*)
begin
if(reset) NextPC=0;
else if(Branch==0) NextPC=PC+4;
else if(Branch==1) NextPC=PC+imm;
else if(Branch==2) NextPC=rs1data+imm;
else if(Branch==4 && zero==0) NextPC=PC+4;
else if(Branch==4 && zero==1) NextPC=PC+imm;
else if(Branch==5 && zero==0) NextPC=PC+imm;
else if(Branch==5 && zero==1) NextPC=PC+4;
else if(Branch==6 && less==0) NextPC=PC+4;
else if(Branch==6 && less==1) NextPC=PC+imm;
else if(Branch==7 && less==0) NextPC=PC+imm;
else if(Branch==7 && less==1) NextPC=PC+4;
end
endmodule