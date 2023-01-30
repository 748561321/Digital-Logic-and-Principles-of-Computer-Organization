module immediate(
input [31:0] instr,
input [2:0] ExtOP,
output reg [31:0]imm
);

always @(*)
begin
if(ExtOP == 3'b000) imm={{20{instr[31]}}, instr[31:20]};
else if(ExtOP == 3'b001) imm={instr[31:12], 12'b0};
else if(ExtOP == 3'b010) imm={{20{instr[31]}}, instr[31:25], instr[11:7]};
else if(ExtOP == 3'b011) imm={{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
else if(ExtOP == 3'b100) imm={{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
end


endmodule
