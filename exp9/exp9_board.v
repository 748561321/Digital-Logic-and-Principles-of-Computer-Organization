
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module exp9_board(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2
);



//=======================================================
//  REG/WIRE declarations
//=======================================================

wire[7:0] a ,c;
wire [7:0] ascii_keyboard;
wire flag;

//=======================================================
//  Structural coding
//=======================================================


keyboard k(CLOCK_50,
	1,
	PS2_CLK,
	PS2_DAT,
	a,//计数
	c,//扫描码
	ascii_keyboard,//ascii
   LEDR[0],//ctrl
   LEDR[1],//shift
	flag,
	LEDR[2]//caps
);
//记录输入的字符 输出ascii码


bcd7seg b0(
	 a[7:4],
	 HEX5,
	 1
	 );
	 
bcd7seg b1(
	 a[3:0],
	 HEX4,
	 1
	 );
	 
/*bcd7seg b2(
	 ascii_keyboard[7:4],
	 HEX3,
	 flag
	 );
	 
bcd7seg b3(
	 ascii_keyboard[3:0],
	 HEX2,
	 flag
	 );
	 
bcd7seg b4(
	 c[7:4],
	 HEX1,
	 flag
	 );
	 
bcd7seg b5(
	 c[3:0],
	 HEX0,
	 flag
	 );*/
	 
	 
	// ram_index[ram_in_addr/71]
	
bcd7seg b3(
   ram_index[ram_in_addr/71][11:8],
	 HEX2,
	 1
	 );

bcd7seg b4(
	 ram_index[ram_in_addr/71][7:4],
	 HEX1,
	 1
	 );
	 
bcd7seg b5(
	 ram_index[ram_in_addr/71][3:0],
	 HEX0,
	 1
	 );
	 
	 
reg [7:0] ascii;
reg [4:0] cnt;
always @(posedge PS2_CLK)
begin
    if(cnt==10)
	begin 
      cnt<=0;
      ascii<=ascii_keyboard;
   end	
	else
   begin
	   cnt<=cnt+1;
	   ascii<=0;
	end
end
	 

//25MHz 每秒约 60 帧 
clkgen #(25000000) my_vgaclk(CLOCK_50,SW[0],1'b1,VGA_CLK);
//vga时钟




assign VGA_SYNC_N=0;

wire [9:0] h_addr;
wire [9:0] v_addr;
reg [23:0] vga_data=0;

reg [11:0] ram_out_addr;
reg [11:0] ram_in_addr;
reg [11:0] address;
wire [7:0] ram_data;
wire [7:0] now_ascii;
wire [8:0] font_data;


always @(VGA_CLK)begin
    ram_out_addr <= (v_addr >> 4) * 71 + ((h_addr+2) / 9);//算出ram中取哪一行
	 
	 address <= (ram_data << 4) + (v_addr % 16);//以取出的ascii码为索引，找到字符表中的位置
	 if(font_data[h_addr % 9] == 1'b1)
		vga_data <= 24'hffffff;
	 else
		vga_data <= 24'h000000;
end	//



reg  [11:0] ram_index [32:0];
reg writein=1;
integer i;

reg flag2=0;
always @ (posedge PS2_CLK)//写入地址改变
	begin
	    if(!flag2)
		 begin
		 for(i=0;i<31;i=i+1)
			ram_index[i]=4095;//初始值
		 flag2=1;

	    end
	
		if(ascii != 0) 
		begin
			if(ascii == 8'h0d) //回车
				begin
					ram_index[ram_in_addr/71]<=ram_in_addr;	
					ram_in_addr <= ram_in_addr + 71 - (ram_in_addr % 71);
					
					writein<=1;
				end
			else if (ascii == 8'h08 )//退格
				begin
					if(ram_in_addr % 71 !=0)
					begin
					ram_in_addr <= ram_in_addr-1;
					  if (ram_index[ram_in_addr/71]== ram_in_addr)
					  ram_index[ram_in_addr/71]<=ram_in_addr-1;
					end
					else//删除回车 退回上一行
						begin
						   if(ram_in_addr < 71 ) 
							begin
							ram_in_addr<=0;
							ram_index[0]=0;
						   end
							else
							begin
						   ram_in_addr <= ram_index[ram_in_addr/71-1];
							ram_index[ram_in_addr/71]<=4095;
							end
						end
					writein<=1;
				end
			else if(ascii == 8'hff )//左
			    begin
				 if(ram_in_addr % 71 !=0)//不在最左边
					ram_in_addr <= ram_in_addr-1;
					else//在最左边
						begin
						   if(ram_in_addr < 71 ) //代表为0 
							ram_in_addr<=0;
							else
						   ram_in_addr <= ram_index[ram_in_addr/71-1];
						end
					writein<=0;
				 end
			else if(ascii == 8'hfe )//下
			    begin
				   if(ram_index[ram_in_addr/71+1]!=4095 && ram_index[ram_in_addr/71+1]%71>=ram_in_addr%71)
					ram_in_addr<=ram_in_addr+71;
					else if(ram_index[ram_in_addr/71+1]!=4095)
				   ram_in_addr<=ram_index[ram_in_addr/71+1];
					
					writein<=0;
				 end
			else if(ascii == 8'hfd) //右
			    begin
				   if(ram_index[ram_in_addr/71]!=4095 && ram_index[ram_in_addr/71]>ram_in_addr)
					ram_in_addr<=ram_in_addr+1;
					else if(ram_index[ram_in_addr/71+1]!=4095)
					ram_in_addr<=ram_in_addr + 71 - (ram_in_addr % 71);
					
					writein<=0;
				 end
			else if(ascii== 8'hfc) //上	
		       begin
				   if(ram_in_addr >=71)
				   if (ram_index[ram_in_addr/71-1] % 71 >=ram_in_addr %71)
					ram_in_addr<=ram_in_addr-71;
					else
					ram_in_addr<=ram_index[ram_in_addr/71-1];
				   writein<=0;
			    end
			else
				begin	
					if((ram_in_addr + 1) % 71 == 0) ram_index[ram_in_addr/71] <= ram_in_addr;
               else ram_index[ram_in_addr/71]<=ram_in_addr+1;
					ram_in_addr <= ram_in_addr + 1;
					
				   writein<=1;
				end
		end

		if(ram_in_addr == 2130) ram_in_addr <= 0;
	end
	

	
keyboard_ram_vga rv(ram_out_addr,
											 ram_in_addr,
							  VGA_CLK,
											 PS2_CLK,
								1'b0,
											 ascii,
							  1'b0,
											 writein,
							 ram_data,
											 now_ascii);
//vga根据block_addr访问显存取出ram_data 
//键盘输入 来改变应当显示的值
//这个模块作用是避免因两个时钟频率不一致而带来的读写时序问题
	

 font (
	address,
	VGA_CLK,
	font_data);


	



vga_ctrl myvga //获取数据 输出地址 输出vga
(
ram_in_addr,

VGA_CLK, //25MHz时钟
0, //置位
vga_data, // 上 层 模 块 提 供 的 VGA颜色数据
h_addr, // 提 供 给 上 层 模 块 的 当 前 扫 描 像 素 点 坐 标
v_addr,
VGA_HS, // 行 同 步 和 列 同 步 信 号
VGA_VS,
VGA_BLANK_N, //消隐信号
VGA_R, // 红 绿 蓝 颜 色 信 号
VGA_G,
VGA_B
 );
 








endmodule