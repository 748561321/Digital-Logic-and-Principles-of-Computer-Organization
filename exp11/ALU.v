module ALU(
	input [31:0] dataa,
	input [31:0] datab,
	input [3:0]  ALUctr,
	output less,
	output zero,
	output reg [31:0] aluresult);

//add your code here
reg less2;
reg zero2;
always @(*)//0101
begin
	case(ALUctr[2:0])
	0:
	begin
	if(ALUctr[3]==0) aluresult=dataa+datab;
	else aluresult=dataa-datab;
	end
	1:aluresult=dataa<<datab[4:0];
	2:if(ALUctr[3]==0)
		begin
		if(dataa[31]==1)
			begin
			if(datab[31]==0) aluresult=1;
			else
				begin
					if(dataa<datab) aluresult=1;
					else aluresult=0;
				end
			end
		else
			begin
			if(datab[31]==1) aluresult=0;
			else
				begin
					if(dataa<datab) aluresult=1;
					else aluresult=0;
				end
			end
			less2=aluresult;
		end
	else
		begin
			if(dataa<datab) aluresult=1;
			else aluresult=0;
			less2=aluresult;
		end
	3:aluresult=datab;
	4:aluresult=dataa^datab;
	5:
	if(ALUctr[3]==0)
	aluresult=dataa>>datab[4:0];
	else
	begin
	aluresult=( {32{dataa[31]}} << ( 6'd32 - {1'b0, datab[4:0]} ) ) | ( dataa >> datab[4:0] ) ;
	end
	6:aluresult=dataa|datab;
	7:aluresult=dataa&datab;


	endcase
	if(ALUctr[2:0]==2)  
	    if(dataa==datab) zero2=1;
		else  zero2=0;
    else
		if(aluresult==0) zero2=1;
		else zero2=0;

end

assign less=less2;
assign zero=zero2;


endmodule