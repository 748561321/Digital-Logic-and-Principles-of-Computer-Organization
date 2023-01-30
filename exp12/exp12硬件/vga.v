module vga(
	input vga_clk, 
   input wrclk, 
	input wren,
	input color_wren,
	input [31:0] wraddr,
	input [31:0] datain,
	input [5:0] start_line, 
	output vga_hs,
	output vga_vs,
	output vga_blank_n,
	output vga_sync_n,
	output reg [7:0] vga_r,
	output reg [7:0] vga_g,
	output reg [7:0] vga_b, 
	input [2:0] memop
	);
	
wire [23:0] vga_data;	// no use
wire [9:0] h_addr;
wire [9:0] v_addr;
wire [7:0] vga_r_tmp;	// no use
wire [7:0] vga_g_tmp; // no use
wire [7:0] vga_b_tmp; // no use
assign vga_sync_n = 0;

vga_ctrl my_vga(vga_clk, 1'b0, vga_data, h_addr, v_addr, vga_hs, vga_vs, vga_blank_n, vga_r_tmp, vga_g_tmp, vga_b_tmp);

wire [5:0] row_out;
wire [6:0] col_out;
wire [7:0] ascii_key_out;

wire [3:0] row_ascii;
wire [3:0] col_ascii;
wire color;
wire test;

vga_font_rom rom1(vga_clk, ascii_key_out, row_ascii, col_ascii, color, test);

assign row_out = (start_line + v_addr[8:4]) & 6'h3f;
assign row_ascii = v_addr[3:0];

assign col_out = h_addr / 9;
assign col_ascii = h_addr % 9;

vga_mem vram(wraddr[14:0], (row_out * 70 + col_out), memop, wrclk, vga_clk, wren, datain, ascii_key_out);

reg [5:0] row_in = 0;
reg [5:0] row_in_tmp;
reg [6:0] col_in = 7'b1111111;

reg [2:0] color_ctrl = 3'b111;

always @ (posedge wrclk)
begin
	if (wren)
	begin
		col_in <= wraddr[12:0] % 70;
		row_in_tmp <= wraddr[12:0] / 70;
		row_in <= (row_in_tmp >= start_line) ? row_in_tmp - start_line : row_in_tmp + (64 - start_line);
	end
	if (color_wren)
	begin
		color_ctrl <= datain[2:0];
	end
end

wire [9:0] sign_h_addr;
wire [9:0] sign_v_addr;

reg sign_color = 1;

wire [6:0] col_sign;
assign col_sign = col_in + 1;
assign sign_h_addr = col_sign * 9;
assign sign_v_addr = row_in << 4;

wire clk_sign;

crossover my_signclk(vga_clk, clk_sign);

always @ (posedge clk_sign)
begin
	sign_color <= ~sign_color;
end

wire color_red;
wire color_green;
wire color_blue;

assign color_red = color && color_ctrl[0];
assign color_green = color && color_ctrl[1];
assign color_blue = color && color_ctrl[2];

always @ (posedge vga_clk)
begin
	if (h_addr > sign_h_addr && h_addr <= sign_h_addr + 1 && v_addr > sign_v_addr && v_addr < sign_v_addr + 15)
	begin
		vga_r[7:0] <= {8{sign_color}};
		vga_g[7:0] <= {8{sign_color}};
		vga_b[7:0] <= {8{sign_color}};
	end
	else if (h_addr > 630)
	begin
		vga_r[7:0] <= {8{1'b0}};
		vga_g[7:0] <= {8{1'b0}};
		vga_b[7:0] <= {8{1'b0}};
	end
	else
	begin
		vga_r[7:0] <= {8{color_red}};
		vga_g[7:0] <= {8{color_green}};
		vga_b[7:0] <= {8{color_blue}};
	end
end

endmodule


module vga_mem(
	input [14:0] wraddr_a,
	input [14:0] wraddr_b,
	input [2:0] memop,
	input inclk,
	input outclk,
	input wren,
	input [31:0] data,
	output [7:0] cur_ascii
);
	
	wire [3:0] byteena_a;
	wire [3:0] byteena_b;
	reg [31:0] datain;
	wire [31:0] buffer;
	wire [31:0] q_a;
	assign cur_ascii = (wraddr_b[1]==1'b1)? ((wraddr_b[0]==1'b1)?buffer[31:24]:buffer[23:16]):((wraddr_b[0]==1'b1)?buffer[15:8]:buffer[7:0]);
	
	font_ram my_font_ram(wraddr_a[14:2], wraddr_b[14:2], byteena_a, byteena_b, datain, datain, inclk, outclk, wren, 1'b0, q_a, buffer);

	byteen_generate a(memop, wraddr_a[1:0], byteena_a);

	byteen_generate b(3'b000, wraddr_b[1:0], byteena_b);

	always @(*)begin  //* only write needs translation 
		if(wren)begin
			case(memop)
				3'b000 : begin
					datain = {{4{data[7:0]}}};
				end
				3'b001 : begin
					datain = {{2{data[15:0]}}};
				end
				default : begin
					datain = data;
				end
			endcase
		end
	end
endmodule