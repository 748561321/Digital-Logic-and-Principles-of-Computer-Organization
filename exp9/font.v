module font (
	address,
	clock,
	q);
input [11:0] address;
input clock;
output [11:0] q;
	
reg [11:0] regs [4095:0];
initial
begin
$readmemh("D:/NJU_ALL/Sophomore/Digital Logic and Principles of Computer Organization/2021/exp9_board/vga_font.txt",regs,0,4095);
end

assign q=regs[address]; 

endmodule
