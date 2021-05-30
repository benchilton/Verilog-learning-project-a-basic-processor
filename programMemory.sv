//when WriteEnable =1 , WriteInstruction is written to the address given. Otherwise every clock cycle the instruction at address is output
module programMemory #(parameter size = 32, instructLen = 32)
		(input logic clk, writeEnable, input logic [instructLen-1:0] writeInstruction, 
		input logic [$clog2(instructLen)-1:0] rAddress, wAddress,
		output logic [instructLen-1:0] outInstruct);

logic [3:0][7:0] programMemory [size-1:0]; // this creates a 32 copies of a 4*8 sized chunk of memory

always_ff @(posedge clk)
begin
		outInstruct <= programMemory[rAddress];
end

always_comb
begin
	if(writeEnable)
		programMemory[wAddress] = writeInstruction;
end

endmodule