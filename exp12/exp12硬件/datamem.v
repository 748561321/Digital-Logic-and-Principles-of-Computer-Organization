module datamem(
	input [2:0] memop,
	input [31:0] data,
	input [16:0] rdaddr,
	input rdclk,
	input [16:0] wraddr,
	input wrclk,
	input wren,
	output reg [31:0] dataout
);
	wire [31:0]q;
	reg [31:0]datain;
	wire [3:0]byteena_a;
	wire [7:0]byteout;
	wire [15:0]wordout;

	assign wordout = (rdaddr[1]==1'b1)? q[31:16]:q[15:0];
	assign byteout = (rdaddr[1]==1'b1)? ((rdaddr[0]==1'b1)?q[31:24]:q[23:16]):((rdaddr[0]==1'b1)?q[15:8]:q[7:0]);

	dmem my_dmem(byteena_a, datain, rdaddr[16:2], rdclk, wraddr[16:2], wrclk, wren, q);

   byteen_generate my_byteen(memop, wraddr[1:0], byteena_a);

	always @ (*)	// read
	begin
		case(memop)
			3'b000 : begin
				dataout = {{24{byteout[7]}}, byteout};
			end
			3'b001 : begin
				dataout = {{16{wordout[15]}}, wordout};
			end
			3'b010 : begin
				dataout = q;
			end
			3'b100 : begin
				dataout = {{24{1'b0}}, byteout};
			end
			3'b101 : begin
				dataout = {{16{1'b0}}, wordout};
			end
			default :begin
				dataout = 32'b0; 
			end
		endcase
	end

	always @ (*) //write
	begin
		if(wren)
		begin
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
		end else begin
			datain <= 32'b0;
		end		
	end
endmodule


module byteen_generate(
	input [2:0]	memop,
	input	[1:0]	addr,
	output reg [3:0] byteen_a
	);
	
	always@(*)begin
		case(memop)
			3'b000:
			begin
				byteen_a[0]=(addr[1:0]==2'b00)?1'b1:1'b0;
				byteen_a[1]=(addr[1:0]==2'b01)?1'b1:1'b0;
				byteen_a[2]=(addr[1:0]==2'b10)?1'b1:1'b0;
				byteen_a[3]=(addr[1:0]==2'b11)?1'b1:1'b0;
			end
			3'b001:
			begin
				byteen_a[0]=(addr[1]==1'b0)?1'b1:1'b0;
				byteen_a[1]=(addr[1]==1'b0)?1'b1:1'b0;
				byteen_a[2]=(addr[1]==1'b1)?1'b1:1'b0;
				byteen_a[3]=(addr[1]==1'b1)?1'b1:1'b0;
			end		
			3'b010:
			begin
				byteen_a=4'b1111;
			end
			default:
			begin
				byteen_a=4'b0000;
			end
		endcase
	end

endmodule