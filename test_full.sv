module test_full;

parameter instructLen = 32;
parameter size = 32;
parameter addsize = $clog2(size);

logic clk, n_rst, writeProgram;
logic branch, jump, memWrite, memRead, regWrite, memToReg, alusrc, regdst, pcToMem,jumpCond, Return;
logic carry, zero, overflow;
logic [5:0] aluControl;
logic [addsize-1:0] wAddress, newCount, PCaddress;
logic [size-1:0] input2_reg, input1, input2, result, result_up;
logic [15:0] immediate;
logic [instructLen-1:0] extended;
logic [5:0] funct;
logic [4:0] rt, rs, rd, write_reg;

assign funct = immediate[5:0];
assign input2 = (alusrc) ? extended : input2_reg;
assign write_reg = (regdst) ? rd : rt;
assign jumpCond = pcToMem & jump;

logic [instructLen-1:0] wInstruction;
logic [instructLen-1:0] fetchInst;//Fetched Instruction

logic [5:0] opcode;
logic [25:0] insAddress;

//Writes to the program memory a basic instruction
machineCode #(.instructLen(instructLen), .size(size)) mc1 (.wE(writeProgram), .wAddress(wAddress), .wInstruction(wInstruction));

branchControl bc1 (.branch(branch), .jump(jump), .zero(zero), .PC_Count(PCaddress), .immediate(extended), .newPC_Count(newCount),
		.Return(Return), .input1(input1));

programCounter #(.size(32)) pC1 (.clk(clk), .n_rst(n_rst), .newCount(newCount), .PCaddress(PCaddress));

programMemory 	pM1 (.clk(clk), .writeEnable(writeProgram), .writeInstruction(wInstruction), .rAddress(PCaddress)
		, .wAddress(wAddress), .outInstruct(fetchInst));

instructionRegister #(.instructLen(instructLen)) iR1 (.clk(clk), .inputInstruction(fetchInst), .address(insAddress), .*);

clockgenerator #(.period(20ns)) clkgen1 (.*);//Clock of period 10ns

signExtend sE1 (.immediate(immediate), .extended(extended));
controller controller1 (.opcode(opcode), .funct(funct), .pcToMem(pcToMem), .*);

register reg1 (.clk(clk), .writeEnable(regWrite), .rAddress1(rs), .rAddress2(rt), .wAddress1(write_reg), .wdata(result), .rdata1(input1)
		, .rdata2(input2_reg), .saveJump(jumpCond), .pcCount(PCaddress));

ALU #(.dataSize(32)) ALU1 (.aluOP(aluControl), .input1(input1), .input2(input2), .result(result), .*);

endmodule
