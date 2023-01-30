module special_reg(
	input rdclk,
	input wrclk,
	input [31:0] wraddr,
	input wren,
	input [31:0] datain,
	output [31:0] dataout,
	output [5:0] line
	);
	
	reg [5:0] line_ctrl = 0;

	wire [31:0] time_read;
	// wire [31:0] time_read_ms;
	timer mytime(rdclk, time_read);
	// timer_ms mytime_ms(rdclk, time_read_ms);
	
	assign dataout = time_read;
	assign line = line_ctrl;
	
	always @ (posedge wrclk)
	begin
		if(wren)
		begin
			line_ctrl <= datain[5:0];
		end 
	end
endmodule


module timer(
	input clk,
	output [31:0] time_out
);
	
	reg [31:0] time_count = 0;
	assign time_out = time_count;
	
	reg [31:0] cnt = 0;
	always@ (posedge clk)
	begin
		if(cnt == 24999)
		begin
			cnt <= 0;
			time_count <= time_count + 1;
		end 
		else 
		begin
			cnt <= cnt + 1;
		end
	end
endmodule


//module timer_ms(
//	input clk,
//	output [31:0] time_out
//);
//	
//	reg [31:0] time_count = 0;
//	assign time_out = time_count;
//	
//	reg [31:0] cnt = 0;
//	always@ (posedge clk)
//	begin
//		if(cnt == 24999)
//		begin
//			cnt <= 0;
//			time_count <= time_count + 1;
//		end 
//		else 
//		begin
//			cnt <= cnt + 1;
//		end
//	end
//endmodule


//module led_ctrl(
//	input wrclk,
//	input [31:0] wraddr,
//	input wren,
//	input [31:0] datain,
//	output [9:0] led_
//	);
//	
//	reg led [9:0];
//	
//	assign led_[0] = led[0];
//	assign led_[1] = led[1];
//	assign led_[2] = led[2];
//	assign led_[3] = led[3];
//	assign led_[4] = led[4];
//	assign led_[5] = led[5];
//	assign led_[6] = led[6];
//	assign led_[7] = led[7];
//	assign led_[8] = led[8];
//	assign led_[9] = led[9];
//	
//	wire [3:0] addr = wraddr[3:0];
//	
//	always @ (posedge wrclk)
//	begin
//		if(wren)
//		begin
//			led[addr] <= datain[0];
//		end 
//	end
//
//endmodule


module led_ctrl(
	input wrclk,
	input [31:0] wraddr,
	input wren,
	input [31:0] datain,
	output [9:0] led_
	);
	
	reg [9:0] led;
	
	assign led_ = led;
	
	wire [3:0] addr = wraddr[3:0];
	
	always @ (posedge wrclk)
	begin
		if(wren)
		begin
			led[addr] <= ~led[addr];
		end 
	end

endmodule


module bcd_ctrl(
	input wrclk,
	input [31:0] wraddr,
	input wren,
	input [31:0] datain,
	output [6:0] bcd_1,
	output [6:0] bcd_2,
	output [6:0] bcd_3,
	output [6:0] bcd_4,
	output [6:0] bcd_5,
	output [6:0] bcd_6
	);
	
	reg [3:0] bcd_mem[5:0];
	
	bcd7seg_alone bcdseg_1(bcd_mem[0], bcd_1);
	bcd7seg_alone bcdseg_2(bcd_mem[1], bcd_2);
	bcd7seg_alone bcdseg_3(bcd_mem[2], bcd_3);
	bcd7seg_alone bcdseg_4(bcd_mem[3], bcd_4);
	bcd7seg_alone bcdseg_5(bcd_mem[4], bcd_5);
	bcd7seg_alone bcdseg_6(bcd_mem[5], bcd_6);
	
	wire [2:0] addr = wraddr[2:0];
	
	always @ (posedge wrclk)
	begin
		if(wren)
		begin
			bcd_mem[addr] <= datain[3:0];
		end 
	end

endmodule


module bcd7seg_alone(
	 input  [3:0] b,
	 output reg [6:0] h
	 );

   //add your code here
	always @ (b)
	begin
		case (b)
		0: h = 7'b1000000;
		1: h = 7'b1111001;
		2: h = 7'b0100100;
		3: h = 7'b0110000;
		4: h = 7'b0011001;
		5: h = 7'b0010010;
		6: h = 7'b0000010;
		7: h = 7'b1111000;
		8: h = 7'b0000000;
		9: h = 7'b0010000;
		10: h = 7'b0001000;
		11: h = 7'b0000011;
		12: h = 7'b1000110;
		13: h = 7'b0100001;
		14: h = 7'b0110000;
		15: h = 7'b0001110;
		default: h = 7'b1111111;
		endcase
	end

endmodule 