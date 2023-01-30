module dmem(
	input  [31:0] addr,
	output reg [31:0] dataout,
	input  [31:0] datain,
	input  rdclk,
	input  wrclk,
	input [2:0] memop,
	input we);

//add your code here

//为 010 时为 4 字节读写
//为 001 时为 2 字节读写带符号扩展
//为 000 时为 1 字节读写带符号扩展
//为 101 时为 2 字节读写无符号扩展
//为 100 时为 1 字节读写无符号扩展

reg [7:0] ram [4096:0];

always @(posedge rdclk)//read
begin
    case(memop)
	0:
	begin
	dataout[7:0]<=ram[addr];
    if(ram[addr][7])
			dataout[31:8]<=24'b111111111111111111111111;
		else
            dataout[31:8]<=24'b000000000000000000000000;
	end
    1:
	begin
    dataout[7:0]<=ram[addr];
	dataout[15:8]<=ram[addr+1];
	if(ram[addr+1][7])
			dataout[31:16]<=16'b1111111111111111;
		else 
		    dataout[31:16]<=16'b0000000000000000;
	end
	2:dataout<={ram[addr+3],ram[addr+2],ram[addr+1],ram[addr]};
	4:
	begin
	dataout[7:0]<=ram[addr];
	dataout[31:8]<=24'b000000000000000000000000;
	end 
	5:
	begin
    dataout[7:0]<=ram[addr];
	dataout[15:8]<=ram[addr+1];
    dataout[31:16]<=16'b0000000000000000;
	end

	endcase
end



always @(posedge wrclk)//write
begin
    if(we)
	begin 
	   case(memop)
       0:
	   begin
       ram[addr]  <= datain[7:0];
	   end
	   1:
	   begin
		ram[addr]  <= datain[7:0];
		ram[addr+1]<= datain[15:8];
       end
	   2:
	   begin
		ram[addr]  <= datain[7:0];
		ram[addr+1]<= datain[15:8];
		ram[addr+2]<= datain[23:16];
		ram[addr+3]<= datain[31:24];
	   end
	   endcase

	end
end

endmodule