module rv32is(
	input 	clock,
	input 	reset,
	output [31:0] imemaddr,
	input  [31:0] imemdataout,
	output 	imemclk,
	output [31:0] dmemaddr,
	input  [31:0] dmemdataout,
	output [31:0] dmemdatain,
	output 	dmemrdclk,
	output	dmemwrclk,
	output [2:0] dmemop,
	output	dmemwe,
	output [31:0] dbgdata);
	
	// pc
	reg [31:0] pc;
	wire [31:0] next_pc;
	
	initial
	begin
		pc = 0;
	end
	
	// instr
	wire [31:0] instr;
	wire [6:0] op;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [4:0] rd;
	wire [2:0] func3;
	wire [6:0] func7;
	wire [31:0] immI;
	wire [31:0] immU;
	wire [31:0] immS;
	wire [31:0] immB;
	wire [31:0] immJ;

	// regfile
	wire [31:0] wrdata;
	wire Regwr;
	wire wrclk;
	wire [31:0] busa;
	wire [31:0] busb;
	
	// alu
	wire [31:0] dataa;
	reg [31:0] datab;
	wire [3:0] ALUctr;
	wire less;
	wire zero;
	wire [31:0] aluresult;
	
	// ctrl_sign
	wire [2:0] extop;
	wire aluasrc;
	wire [1:0] alubsrc;
	wire [2:0] branch;
	wire memtoreg;
	wire memwr;
	wire [2:0] memop;
	
	// pc_generation
	reg [31:0] imm;
	wire [31:0] nextpc;
	
	regfile myregfile(rs1, rs2, rd, wrdata, Regwr, wrclk, busa, busb);
	alu myalu(dataa, datab, ALUctr, less, zero, aluresult);
	ctrl_generation myctrl(op, func3, func7, extop, Regwr, aluasrc, alubsrc, ALUctr, branch, memtoreg, memwr, memop);
	pc_generation mypc(branch, zero, less, pc, imm, busa, nextpc);
	
	// pc
	assign dbgdata = pc;
	
	// instr
	assign instr = imemdataout;
	assign op = instr[6:0];
	assign rs1 = instr[19:15];
	assign rs2 = instr[24:20];
	assign rd = instr[11:7];
	assign func3 = instr[14:12];
	assign func7 = instr[31:25];
	assign immI = {{20{instr[31]}}, instr[31:20]};
	assign immU = {instr[31:12], 12'b0};
	assign immS = {{20{instr[31]}}, instr[31:25], instr[11:7]};
	assign immB = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
	assign immJ = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
	
	// ctrl_sign
	assign dmemop = memop;
	assign dmemwe = memwr;
	
	// clock
	assign imemclk = ~clock;
	assign dmemrdclk = clock;
	assign dmemwrclk = ~clock;
	
	// reg
	assign wrclk = clock;
	assign wrdata = (memtoreg)? dmemdataout : aluresult;
	
	// addr
	assign imemaddr = next_pc;
	assign dmemaddr = aluresult;
	assign next_pc = (reset)? 0 : nextpc;
	
	// dmem
	assign dmemdatain = busb;
	
	// alu_data
	assign dataa = (aluasrc)? pc : busa;
	always @ (*)
	begin
		if (alubsrc == 2'b00)
			datab = busb;
		else if (alubsrc == 2'b01)
			datab = imm;
		else if (alubsrc == 2'b10)
			datab = 4;
	end
	
	// choose the imm
	always @ (*)
	begin
		if (extop == 3'b000)
			imm = immI;
		else if (extop == 3'b001)
			imm = immU;
		else if (extop == 3'b010)
			imm = immS;
		else if (extop == 3'b011)
			imm = immB;
		else if (extop == 3'b100)
			imm = immJ;
	end
	
	always @ (negedge clock)
	begin
		if (reset == 1)
		begin
			pc = 0;
		end
		else
		begin
			pc = next_pc;
		end
	end

endmodule


module pc_generation(
	input [2:0] branch,
	input zero,
	input less,
	input [31:0] pc,
	input [31:0] imm,
	input [31:0] rs1,
	output reg [31:0] nextpc);
	
	always @ (*)
	begin
		if (branch == 3'b000)
		begin
			nextpc = pc + 4;
		end
		else if (branch == 3'b001)
		begin
			nextpc = pc + imm;
		end
		else if (branch == 3'b010)
		begin
			nextpc = rs1 + imm;
		end
		else if (branch == 3'b100 && zero == 0)
		begin
			nextpc = pc + 4;
		end
		else if (branch == 3'b100 && zero == 1)
		begin
			nextpc = pc + imm;
		end
		else if (branch == 3'b101 && zero == 0)
		begin
			nextpc = pc + imm;
		end
		else if (branch == 3'b101 && zero == 1)
		begin
			nextpc = pc + 4;
		end
		else if (branch == 3'b110 && less == 0)
		begin
			nextpc = pc + 4;
		end
		else if (branch == 3'b110 && less == 1)
		begin
			nextpc = pc + imm;
		end
		else if (branch == 3'b111 && less == 0)
		begin
			nextpc = pc + imm;
		end
		else if (branch == 3'b111 && less == 1)
		begin
			nextpc = pc + 4;
		end
	end
	
endmodule


module ctrl_generation(
	input [6:0] op,
	input [2:0] func3,
	input [6:0] func7,
	output reg [2:0] extop,
	output reg regwr,
	output reg aluasrc,
	output reg [1:0] alubsrc,
	output reg [3:0] aluctr,
	output reg [2:0] branch,
	output reg memtoreg,
	output reg memwr,
	output reg [2:0] memop);
	
	wire [4:0] op_use;
	wire func7_use;
	
	assign op_use = op[6:2];
	assign func7_use = func7[5];
	
	always @ (*)
	begin
		if (op_use == 5'b01101)
		begin
			extop = 3'b001;
			regwr = 1;
			branch = 3'b000;
			memtoreg = 0;
			memwr = 0;
			alubsrc = 2'b01;
			aluctr = 4'b0011;
		end
		else if (op_use == 5'b00101)
		begin
			extop = 3'b001;
			regwr = 1;
			branch = 3'b000;
			memtoreg = 0;
			memwr = 0;
			aluasrc = 1;
			alubsrc = 2'b01;
			aluctr = 4'b0000;
		end
		else if (op_use == 5'b00100)
		begin
			extop = 3'b000;
			regwr = 1;
			branch = 3'b000;
			memtoreg = 0;
			memwr = 0;
			aluasrc = 0;
			alubsrc = 2'b01;
			if (func3 == 3'b000)
				aluctr = 4'b0000;
			else if (func3 == 3'b010)
				aluctr = 4'b0010;
			else if (func3 == 3'b011)
				aluctr = 4'b1010;
			else if (func3 == 3'b100)
				aluctr = 4'b0100;
			else if (func3 == 3'b110)
				aluctr = 4'b0110;
			else if (func3 == 3'b111)
				aluctr = 4'b0111;
			else if (func3 == 3'b001 && func7_use == 0)
				aluctr = 4'b0001;
			else if (func3 == 3'b101 && func7_use == 0)
				aluctr = 4'b0101;
			else if (func3 == 3'b101 && func7_use == 1)
				aluctr = 4'b1101;
		end
		else if (op_use == 5'b01100)
		begin
			regwr = 1;
			branch = 3'b000;
			memtoreg = 0;
			memwr = 0;
			aluasrc = 0;
			alubsrc = 2'b00;
			if (func3 == 3'b000 && func7_use == 0)
				aluctr = 4'b0000;
			else if (func3 == 3'b000 && func7_use == 1)
				aluctr = 4'b1000;
			else if (func3 == 3'b001 && func7_use == 0)
				aluctr = 4'b0001;
			else if (func3 == 3'b010 && func7_use == 0)
				aluctr = 4'b0010;
			else if (func3 == 3'b011 && func7_use == 0)
				aluctr = 4'b1010;
			else if (func3 == 3'b100 && func7_use == 0)
				aluctr = 4'b0100;
			else if (func3 == 3'b110 && func7_use == 0)
				aluctr = 4'b0110;
			else if (func3 == 3'b111 && func7_use == 0)
				aluctr = 4'b0111;
			else if (func3 == 3'b101 && func7_use == 0)
				aluctr = 4'b0101;
			else if (func3 == 3'b101 && func7_use == 1)
				aluctr = 4'b1101;
		end
		else if (op_use == 5'b11011)
		begin
			extop = 3'b100;
			regwr = 1;
			branch = 3'b001;
			memtoreg = 0;
			memwr = 0;
			aluasrc = 1;
			alubsrc = 2'b10;
			aluctr = 4'b0000;
		end
		else if (op_use == 5'b11001 && func3 == 3'b000)
		begin
			extop = 3'b000;
			regwr = 1;
			branch = 3'b010;
			memtoreg = 0;
			memwr = 0;
			aluasrc = 1;
			alubsrc = 2'b10;
			aluctr = 4'b0000;
		end
		else if (op_use == 5'b11000)
		begin
			extop = 3'b011;
			regwr = 0;
			memwr = 0;
			case (func3)
			3'b000: branch = 3'b100;
			3'b001: branch = 3'b101;
			3'b100: branch = 3'b110;
			3'b101: branch = 3'b111;
			3'b110: branch = 3'b110;
			3'b111: branch = 3'b111;
			endcase
			aluasrc = 0;
			alubsrc = 2'b00;
			if (func3 == 3'b110 || func3 == 3'b111)
				aluctr = 4'b1010;
			else if (func3 == 3'b000 || func3 == 3'b001 || func3 == 3'b100 || func3 == 3'b101)
				aluctr = 4'b0010;
		end
		else if (op_use == 5'b00000)
		begin
			extop = 3'b000;
			regwr = 1;
			branch = 3'b000;
			memtoreg = 1;
			memwr = 0;
			memop = func3;
			if (func3 == 3'b000 || func3 == 3'b001 || func3 == 3'b010 || func3 == 3'b100 || func3 == 3'b101)
			begin
			aluasrc = 0;
			alubsrc = 2'b01;
			aluctr = 4'b0000;
			end
		end
		else if (op_use == 5'b01000 && (func3 == 3'b000 || func3 == 3'b001 || func3 == 3'b010))
		begin
			extop = 3'b010;
			regwr = 0;
			branch = 3'b000;
			memwr = 1;
			memop = func3;
			aluasrc = 0;
			alubsrc = 2'b01;
			aluctr = 4'b0000;
		end
	end
	
endmodule


 module regfile(input [4:0]  ra,
	input  [4:0]  rb,
	input  [4:0]  rw,
	input  [31:0] wrdata,
	input  regwr,
	input  wrclk,
	output [31:0] busa,
	output [31:0] busb
	);
	
	//The regfile
	reg [31:0] regs[31:0];	
	
	initial
	begin
		regs[0] = 0;
	end
	
	assign busa = regs[ra];
	assign busb = regs[rb];

	always @ (negedge wrclk)
	begin
		if (regwr == 1 && rw != 0)
		begin
			regs[rw] = wrdata;
		end
	end

endmodule


module alu(
	input [31:0] dataa,
	input [31:0] datab,
	input [3:0]  ALUctr,
	output less,
	output zero,
	output reg [31:0] aluresult);

//add your code here
reg [31:0] datac;
reg [31:0] dataf;
reg cf;
reg addsub;
reg of;
reg less_value;
reg zero_value;

assign zero = zero_value;
assign less = less_value;

always @ (*)
begin
	if (ALUctr[2:0] == 3'b000)
	begin
		addsub = ALUctr[3];
		datac = {32{addsub}} ^ datab;
		aluresult = dataa + datac + addsub;
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 4'b001)
	begin
		aluresult = dataa << datab[4:0];
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 3'b010)
	begin
		zero_value = (dataa == datab);
		datac = {32{1'b1}} ^ datab;
		{cf, dataf} = dataa + datac + 1'b1;
		cf = cf ^ 1;
		of = (dataa[31] == datac[31]) && (dataf[31] != dataa[31]);
		if (ALUctr[3] == 1)
		begin
			if (cf == 0)
			begin
				aluresult = 0;
				less_value = 0;
			end
			else
			begin
				aluresult = 1;
				less_value = 1;
			end
		end
		else
		begin
			if (dataf[31] == of || zero == 1)
			begin
				less_value = 0;
				aluresult = 0;
			end
			else
			begin
				less_value = 1;
				aluresult = 1;
			end
		end
	end
	else if (ALUctr[2:0] == 3'b011)
	begin
		aluresult = datab;
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 3'b100)
	begin
		aluresult = dataa ^ datab;
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 3'b101)
	begin
		if (ALUctr[3] == 0)
			aluresult = dataa >> datab[4:0];
		else
		begin
			aluresult[31:0] = ( {32{dataa[31]}} << ( 6'd32 - {1'b0, datab[4:0]} ) ) | ( dataa >> datab[4:0] ) ;
		end
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 3'b110)
	begin
		aluresult = dataa | datab;
		zero_value = ~(|aluresult);
	end
	else if (ALUctr[2:0] == 3'b111)
	begin
		aluresult = dataa & datab;
		zero_value = ~(|aluresult);
	end
end

endmodule