module Control(
input [4:0]op,
input [2:0]func3,
input func7,
output reg [2:0] ExtOP,
output reg RegWr,
output reg [2:0] Branch,
output reg MemtoReg,
output reg MemWr,
output reg [2:0]MemOP,
output reg ALUAsrc,
output reg [1:0]ALUBsrc,
output reg [3:0]ALUctr
);


always @(*)
begin
if(op==5'b01101)
        begin ExtOP = 3'b001;RegWr=1;Branch=3'b000;MemtoReg=0;MemWr=0;ALUBsrc=1;ALUctr=3; end
else if(op==5'b00101)
        begin ExtOP = 3'b001;RegWr=1;Branch=3'b000;MemtoReg=0;MemWr=0;ALUAsrc=1;ALUBsrc=1;ALUctr=0; end
else if(op==5'b00100)
	     begin 
		  ExtOP = 3'b000;RegWr=1;Branch=3'b000;MemtoReg=0;MemWr=0;
		  ALUAsrc=0;ALUBsrc=1;
		  if(func3==0) ALUctr=0;
		  else if(func3==2) ALUctr=2;
		  else if(func3==3) ALUctr=10;
		  else if(func3==4) ALUctr=4;
		  else if(func3==6) ALUctr=6;
		  else if(func3==7) ALUctr=7;
		  else if(func3==1 && func7==0 ) ALUctr=1;
		  else if(func3==5 && func7==0 ) ALUctr=5;
		  else if(func3==5 && func7==1 ) ALUctr=13;
		  end
else if(op==5'b01100)
        begin
		  RegWr=1;Branch=3'b000;MemtoReg=0;MemWr=0;ALUAsrc=0;ALUBsrc=0;
		  if({func3[2:0],func7}==4'b0000) ALUctr=4'b0000;
		  else if({func3[2:0],func7}==4'b0001) ALUctr=4'b1000;
		  else if({func3[2:0],func7}==4'b0010) ALUctr=4'b0001;
		  else if({func3[2:0],func7}==4'b0100) ALUctr=4'b0010;
		  else if({func3[2:0],func7}==4'b0110) ALUctr=4'b1010;
		  else if({func3[2:0],func7}==4'b1000) ALUctr=4'b0100;
		  else if({func3[2:0],func7}==4'b1010) ALUctr=4'b0101;
		  else if({func3[2:0],func7}==4'b1011) ALUctr=4'b1101;
		  else if({func3[2:0],func7}==4'b1100) ALUctr=4'b0110;
		  else if({func3[2:0],func7}==4'b1110) ALUctr=4'b0111;
		  end
else if(op==5'b11011)
       begin ExtOP = 3'b100;RegWr=1;Branch=3'b001;MemtoReg=0;MemWr=0;ALUAsrc=1;ALUBsrc=2;ALUctr=0; end
else if(op==5'b11001)
       begin ExtOP = 3'b000;RegWr=1;Branch=3'b010;MemtoReg=0;MemWr=0;ALUAsrc=1;ALUBsrc=2;ALUctr=0; end
else if(op==5'b11000)
       begin ExtOP = 3'b011;RegWr=0;MemWr=0;
		 ALUAsrc=0;ALUBsrc=0;
		 if(func3==3'b000) Branch=3'b100;
		 else if(func3==3'b001) Branch=3'b101;
		 else if(func3==3'b100) Branch=3'b110;
		 else if(func3==3'b101) Branch=3'b111;
		 else if(func3==3'b110) Branch=3'b110;
		 else if(func3==3'b111) Branch=3'b111;
		 
		 if(func3[1]==1) ALUctr=4'b1010;
		 else ALUctr=4'b0010;
		 end
else if(op==5'b00000)
       begin ExtOP=3'b000;RegWr=1;Branch=3'b000;MemtoReg=1;MemWr=0;MemOP=func3;ALUAsrc=0;ALUBsrc=1;ALUctr=0;end
else if(op==5'b01000)
       begin ExtOP=3'b010;RegWr=0;Branch=3'b000;MemWr=1;MemOP=func3;ALUAsrc=0;ALUBsrc=1;ALUctr=0;end
end
endmodule
