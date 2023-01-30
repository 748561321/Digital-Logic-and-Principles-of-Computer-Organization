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
	
//add your code here

/*
input     clock, //CPU时钟，下降沿有效
input     reset, //reset信号，高电平有效
input  [31:0] imemdataout,//指令存储器提供的32位指令数据
input  [31:0] dmemdataout,//数据存储器提供的32位读取数据
output [31:0] imemaddr,//32位指令地址
output     imemclk,//指令读取时钟，上升沿读取，如果要在时钟下降沿读取指令，请将时钟取反后提供给imemclk
output [31:0] dmemaddr,//32位数据地址
output [31:0] dmemdatain,//32位写入数据内容
output     dmemrdclk,//数据存储器的读取时钟，上升沿有效，
output    dmemwrclk, //数据存储器的写入时钟，上升沿有效，如果要在CPU时钟的下降沿写入，请将CPU时钟取反后输出到本信号上
output [2:0] dmemop,//数据存储器的读写方式，按讲义设置
output    dmemwe,//数据存储器写使能，高电平有效
output [31:0] dbgdata//32位测试数据，本实验中请将PC连接到此信号上
*/


wire [4:0]rs1;//源寄存器1
wire [4:0]rs2;//源寄存器2
wire [4:0]rd;//目的寄存器
wire [2:0]Branch;
wire ALUAsrc;
wire [1:0]ALUBsrc;
wire [3:0]ALUctr;
wire MemtoReg;
wire MemWr;
wire RegWr;
wire [2:0]MemOP;
wire [31:0]rs1data;
wire [31:0]rs2data;
reg [31:0]wrdata;
wire [2:0]ExtOP;
wire [31:0]imm;
wire [31:0]aluresult;
reg [31:0]dataa;
reg [31:0]datab;
wire zero;
wire less;
reg [31:0]PC;
wire [31:0]NextPC;
initial
begin
	PC=0;
end

assign rs1 = imemdataout[19:15];
assign rs2 = imemdataout[24:20];
assign rd = imemdataout[11:7];

assign imemclk=~clock;//指令 下降沿读取
assign dmemrdclk=clock;//数据 上升沿读取
assign dmemwrclk=~clock;//数据 下降沿写入

Control A(imemdataout[6:2],imemdataout[14:12],imemdataout[30],ExtOP,RegWr,Branch,MemtoReg,MemWr,MemOP,ALUAsrc,ALUBsrc,ALUctr);
regfile myregfile(rs1,rs2,rd,wrdata,RegWr,~clock,rs1data,rs2data);//下降沿写入 读取
immediate B(imemdataout,ExtOP,imm);
PC_ C(PC,imm,rs1data,Branch,zero,less,NextPC,reset);
ALU D(dataa,datab,ALUctr,less,zero,aluresult);

always @(negedge clock)
	PC<=NextPC;

always @(*)
begin
if(MemtoReg)
	wrdata=dmemdataout;
else
	wrdata=aluresult;
if(ALUAsrc==0)
	dataa=rs1data;
else
	dataa=PC;
if(ALUBsrc==2'b00)
	datab=rs2data;
else if(ALUBsrc==2'b01)
	datab=imm;
else if(ALUBsrc==2'b10)
	datab=4;
end

assign imemaddr=NextPC;
assign dbgdata=PC;
assign dmemwe=MemWr;
assign dmemop=MemOP;
assign dmemdatain=rs2data;
assign dmemaddr=aluresult;
endmodule
