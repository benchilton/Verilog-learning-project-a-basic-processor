//Instructions are formatted as such (with bit size shown in brackets):

//R Type:|opcode (6)|rs (5)|rt (5)|rd (5)|shamt (5)|funct (6)|
//I Type:|opcode (6)|rs (5)|rt (5)|immediate (16)|
//J Type:|opcode (6)|address (26)|

module instructionRegister #(parameter instructLen) (input logic clk, input logic [instructLen-1:0] inputInstruction,
				output logic [5:0] opcode, output logic [4:0] rt, rs, rd, output logic [15:0] immediate,
				output logic [25:0] address);

always_ff @(posedge clk)
begin
	opcode = inputInstruction[31:26];
	rs = inputInstruction[25:21];
	rt = inputInstruction[20:16];
	rd = inputInstruction[15:11];
	immediate = inputInstruction[15:0];//note 10:6 is shamt, 5:0 is funct.
	address = inputInstruction[25:0];
end
endmodule
