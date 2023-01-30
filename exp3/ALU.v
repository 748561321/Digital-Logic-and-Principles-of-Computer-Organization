module ALU( input [3:0] A,
			  input [3:0] B,
			  input [2:0] ALUctr,
			  output reg [3:0] F,
			  output reg cf,
			  output reg zero,
			  output reg of
);

//add your code here
reg[4:0] t;
always @(*)
begin
  case (ALUctr)
  0: begin
	F=A+B;
	zero=~( | F);
	cf=(A+B>F);
	of=(F!=A+B);
  end
  1:begin
	F=A-B;
	zero=~( | F);
	of=(F!=A-B);
	t=A-B;
	cf=t[4];
  end
  2:begin
    F=~A;
	cf=0;
	of=0;
	zero=~( | F);
  end
  3:begin
    F=A&B;
	cf=0;
	of=0;
    zero=~( | F);
  end
  4:begin
    F=A|B;
	cf=0;
	of=0;
    zero=~( | F);
  end
  5:begin
    F=A^B;
	cf=0;
	of=0;
    zero=~( | F);
  end
  6:begin
    if(A[3]==0)
	begin
       if(B[3]==0)
	   begin
         if(A>B) F=4'b0001;
		 else F=4'b0000;
	   end
	   else
	     F=4'b0001;
	end
	else
	begin
       if(B[3]==0)
	   F=4'b0000;
	   else
	   begin
         if(A>B) F=4'b0001;
		 else F=4'b0000;
	   end
	end
	cf=0;
	of=0;
    zero=~( | F);
  end
  7:begin
  if(A==B) F=4'b0001;
  else F=4'b0000;
  cf=0;
  of=0;
  zero=~( | F);
  end
  endcase

end


endmodule