 module regfile(
	input  [3:0]  rw, //地址端
	input  [3:0] wrdata, //数据端
	input  regwr,  //使能端 
	input  wrclk,  //时钟信号
	output [7:0] outa  //输出端
	);
	
	//The regfile
	reg [7:0] regs[15:0];	
	
	//add your code here
initial
begin
$readmemh("D:/NJU_ALL/Sophomore/Digital Logic and Principles of Computer Organization/2021/exp5_board/mem1.txt", regs, 0, 15);
end

always @(posedge wrclk)
begin
    if(regwr)//写入
	begin 
      regs[rw]=wrdata;
		regs[0]=0;
	end
end

assign outa=regs[rw];
	
endmodule
