//This will write a simple machine code program to the program memory over a time of n nanoseconds.
//Update in the future when the complete architecture is completed to make a simple program
/*
Instruction formats:
R Type:|opcode (6)|rs (5)|rt (5)|rd (5)|shamt (5)|funct (6)|
I Type:|opcode (6)|rs (5)|rt (5)|immediate (16)|
J Type:|opcode (6)|address (26)|
*/
`include "instructions.sv"
program machineCode #(parameter instructLen, parameter size) (output logic wE,output logic [$clog2(instructLen)-1:0] wAddress,
						output logic [instructLen-1:0] wInstruction);
parameter codeSize = 12;
const var [size-1:0] code [codeSize-1:0] = '{
{`ADDI,`zero,`s7,16'h10},//Add the numbers 0 and 16'b0001000011010110 and put it in the temporary register 8
{`ADDI,`zero,`s8,16'h1FF},
{`rtype,`s7,`s8,`s9,5'b0,`ADD},
{`JAL,26'h0A},
{`ADDI,`zero,`s1,16'b100},
{`rtype,`s1,`s8,`s2,5'b0,`SUB},
{`rtype,`s2,5'b0,5'b0,5'h03,`SRL},
{`rtype,`s2,`s7,`s3,5'b0,`AND},
{`J,26'h1},
{`ADDI,`zero,`s0,16'hFF},//10
{`rtype,`s1,5'b0,5'b0,5'h02,`SLL},
{`rtype,`ra,5'b0,5'b0,5'b0,`JR}/*,
{6'b001100,5'b01001,5'b01101,16'b0000000011000110},
{6'b001101,5'b01000,5'b01101,16'b0000100011010110},
{6'b001110,5'b01110,5'b01101,16'b0000001011010110},
{6'b001111,5'b00001,5'b01101,16'b0000000011010110}
*/};

const var [size-1:0] NOP = '{{6'b111111,26'b00000000000000000000000000}};//NOP use to fill the rest of unused memory

int i;

initial
begin
	wE = '1;
	for (int j = 0; j <= 32 + codeSize; j++)
	begin
		wAddress = j;
		wInstruction = NOP;
		#1ps;
	end
	#1ps;
	for (i = 0; i <= codeSize-1; i++)
		begin
		wAddress = i;
		wInstruction = code[codeSize - i - 1];
		#1ps;
		end
	#1ps wE = '0;
	#1us;
end

endprogram
