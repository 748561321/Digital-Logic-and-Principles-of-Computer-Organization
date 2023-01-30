`timescale 1ns/10ps

module seg_dec_tb;
reg  [3:0] b;
wire [6:0] h;
	 
seg_dec seg_dec(.b(b),.h(h));

initial begin
  
        b=4'd0;
#10     b=4'd1;
#10     b=4'd2;
#10     b=4'd3;
#10     b=4'd4;
#10     b=4'd5;
#10     b=4'd6;
#10     b=4'd7;
#10     b=4'd8;
#10     b=4'd9;
#10     b=4'd10;
#10     b=4'd11;
#10     b=4'd12;
#10     b=4'd13;
#10     b=4'd14;
#10     b=4'd15;
#10     ;

end

endmodule
