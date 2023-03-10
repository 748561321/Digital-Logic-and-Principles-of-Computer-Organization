
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module exp4_2_board(

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// Seg7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [3:0]a;
wire [3:0]b;
wire [3:0]c;
wire [3:0]d;
wire [3:0]e;
wire [3:0]f;
mux3_1 m(
  SW[9:8],//选择段
  CLOCK_50,
  KEY[3:0],
  SW[0],//使能端
  SW[1],//重置位
  
  
  LEDR[0],
  a,
  b,
  c,
  d,
  e,
  f
);
bcd7seg b1(a,HEX0);
bcd7seg b2(b,HEX1);
bcd7seg b3(c,HEX2);
bcd7seg b4(d,HEX3);
bcd7seg b5(e,HEX4);
bcd7seg b6(f,HEX5);


//=======================================================
//  Structural coding
//=======================================================



endmodule
