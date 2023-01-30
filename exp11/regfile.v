module regfile (
input [4:0]rs1,
input [4:0]rs2,
input [4:0]rd,
input [31:0]wrdata,
input RegWr,
input clock,
output [31:0]rs1data,
output [31:0]rs2data
);
reg [31:0] regs [31:0];

always @(posedge clock)
begin
if(RegWr)
regs[rd] <= wrdata;

regs[0]<=0;
end

assign rs1data=regs[rs1];
assign rs2data=regs[rs2];

endmodule
