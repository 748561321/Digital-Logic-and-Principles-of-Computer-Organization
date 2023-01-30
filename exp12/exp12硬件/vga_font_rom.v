module vga_font_rom(input clk,
	input [7:0] ascii_key,
	input [3:0] row,
	input [2:0] col,
	output reg color,
	output reg [11:0] test
	);
	
	reg [11:0] rom [4095:0];
	
	initial
   begin
		$readmemh("D:/QuartusProject/exp9/vga_font.txt", rom, 0, 4095);
   end
	
	always @ (posedge clk)
	begin
		color <= rom[{ascii_key, 4'b0} + row][col];
		test <= rom[18];
	end
endmodule