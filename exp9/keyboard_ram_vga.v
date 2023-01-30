module keyboard_ram_vga (
                    ram_out_addr,
											 ram_in_addr,
							  VGA_CLK,
											 PS2_CLK,
								data_a,
											 ascii,
							  wren_a,
											 wren_b,
							 ram_data,
											 now_ascii);
//vga根据block_addr访问显存取出ram_data 
//键盘输入 来改变应当显示的值
//这个模块作用是避免因两个时钟频率不一致而带来的读写时序问题
   reg [7:0] regs[4095:0];
	
	input	[11:0]  ram_out_addr;
	input	[11:0]  ram_in_addr;
	input	  VGA_CLK;
	input	  PS2_CLK;
	input	[7:0]  data_a;
	input	[7:0]  ascii;
	input	  wren_a;
	input	  wren_b;
	output	reg [7:0]  ram_data;
	output	[7:0]  now_ascii=0;
	
	reg [7:0] preascii;
	integer flag1=0;
	integer flag2=0;
	
	reg prewren;
	
always @(posedge VGA_CLK)
begin
     ram_data<= regs[ram_out_addr];
end

always @(posedge PS2_CLK)
begin
    
	 if(wren_b && ascii!=8'h0d && ascii!=8'h08 && ascii!=8'hff && ascii!=8'hfe && ascii!=8'hfd && ascii!=8'hfc)
	 regs[ram_in_addr]<=ascii;

end




endmodule
	
	
	
	