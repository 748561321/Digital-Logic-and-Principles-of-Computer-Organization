module vga_ctrl(
input pclk, //25MHz时钟
input reset, //置位
input [11:0] vga_data, // 上 层 模 块 提 供 的 VGA颜色数据
output [9:0] h_addr, // 提 供 给 上 层 模 块 的 当 前 扫 描 像 素 点 坐 标
output [9:0] v_addr,
output hsync, // 行 同 步 和 列 同 步 信 号
output vsync,
output valid, //消隐信号
output [7:0] vga_r, // 红 绿 蓝 颜 色 信 号
output [7:0] vga_g,
output [7:0] vga_b
 );



 //640x480 分辨 率 下的 VGA参数设置
 parameter h_frontporch = 96;
 parameter h_active = 144;
 parameter h_backporch = 784;
 parameter h_total = 800;

 parameter v_frontporch = 2;
 parameter v_active = 35;
 parameter v_backporch = 515;
 parameter v_total = 525;
 



 // 像素 计 数值
 reg [9:0] x_cnt;
 reg [9:0] y_cnt;
 wire h_valid;
 wire v_valid;

 always @(posedge reset or posedge pclk) // 行像素计数
 if (reset == 1'b1)
 x_cnt <= 1;
 else
 begin
 if (x_cnt == h_total)
 x_cnt <= 1;
 else
 x_cnt <= x_cnt + 10'd1;
 end

 always @(posedge pclk) // 列像素计数
 if (reset == 1'b1)
 y_cnt <= 1;
 else
 begin
 if (y_cnt == v_total & x_cnt == h_total)
 y_cnt <= 1;
 else if (x_cnt == h_total)
 y_cnt <= y_cnt + 10'd1;
 end
 // 生 成 同 步 信 号
 assign hsync = (x_cnt > h_frontporch);
 assign vsync = (y_cnt > v_frontporch);
 // 生 成 消 隐 信 号
 assign h_valid = (x_cnt > h_active) & (x_cnt <= h_backporch);
 assign v_valid = (y_cnt > v_active) & (y_cnt <= v_backporch);
 assign valid = h_valid & v_valid;
 // 计 算 当 前 有 效 像 素 坐 标
 assign h_addr = h_valid ? (x_cnt - 10'd145) : {10{1'b0}};
 assign v_addr = v_valid ? (y_cnt - 10'd36) : {10{1'b0}};
 /*显存分配大小为 640 × 512 word, 每个 word 为 12bit。用 h_addr 的全部 10
位和 v_addr 的低 9 位合成 19 位地址来索引显存。为方便寻址，我们给行
v_addr 分配了 512 行的空间。这样，可以不用对地址进行复杂的转换。此
处只需要分配 327680 个连续的存储单元，不需要考虑 h_addr 大于 640 的情
况。
assign 红、绿、蓝颜色的时候，根据 12bit 显存数据中对应颜色的 4bit 值，
设置输出 8bit 数据的高 4 位，低 4 位置零。
对显存用.mif 文件初始化。可以自己用常用的脚本语言生成.mif 文件，我们
也提供了一张 640×512 的 12bit 图片的 my_picture.mif 文件，其中每像素按
RGB 各 4 比特，地址按列排列，开头是第一列像素 512 个点，其中超过 480
行的像素置为白色。然后顺序排列 640 列像素。*/
wire [3:0] zero=0;

 
 // 设 置 输 出 的 颜 色 值
 assign vga_r = {vga_data[11:8],zero};
 assign vga_g = {vga_data[7:4],zero};
 assign vga_b = {vga_data[3:0],zero};
 endmodule
 
 