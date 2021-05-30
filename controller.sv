//Takes in the opcode of the in struction and figures out what it does
module controller (input logic [5:0] opcode, input logic [5:0] funct, 
		output logic regdst, alusrc, memToReg, regWrite, memRead, memWrite, branch, jump, pcToMem, Return, 
		output logic [5:0] aluControl);

logic aluop;//Internal signal used to calculate which aluControl to use
logic [5:0] aluControl_R, aluControl_IJ;
logic alusrc_shift, alusrc_other;

aluControl alucon1 (.funct(funct), .aluOp(aluop), .aluControl_R(aluControl_R), .alusrc_shift(alusrc_shift));

assign alusrc = (alusrc_shift) ?  alusrc_shift: alusrc_other;
assign aluControl = (aluop == 1) ? aluControl_R : aluControl_IJ;//ALUOP = 1 if the instruction is R-Type.

always_comb
begin
	regdst = 1'b0;
	alusrc_other = 1'b0;
	memToReg = 1'b0;
	regWrite = 1'b0;
	memRead = 1'b0;
	memWrite = 1'b0;
	branch = 1'b0;
	aluop = 1'b0;
	jump = 1'b0;
	pcToMem = 1'b0;
	aluControl_IJ = 6'b111111;
	Return = '0;
	
	if(funct == 6'b001000 && opcode == 6'b000000)
	begin
		jump = 1'b1;
		Return = 1'b1;
	end

	unique case(opcode)
	6'b000000://R-Type
	begin
		regdst = '1;
		regWrite = '1;
		aluop = 1;
	end
	6'b001000://Addi
	begin
		alusrc_other = '1;
		regWrite = '1;
		aluControl_IJ = 6'b000010;
	end
	6'b001001://ADDIU
	begin
		alusrc_other = '1;
		regWrite = '1;
		aluControl_IJ = 6'b000010;
	end
	6'b001100://ANDI
	begin
		alusrc_other = '1;
		regWrite = '1;
		aluControl_IJ = 6'b000000;
	end
	6'b001101://ORI
	begin
		alusrc_other = '1;
		regWrite = '1;
		aluControl_IJ = 6'b000101;
	end
	6'b001110://XORI
	begin
		alusrc_other = '1;
		memToReg = '1;
		regWrite = '1;
		memRead = '1;
	end
	6'b101011://Save Word
	begin
		regdst = 1'b?;
		alusrc_other = '1;
		memToReg = 1'b?;
		memWrite = '1;
	end
	6'b000100://Branch if equal
	begin
		regdst = 1'b0;
		memToReg = 1'b0;
		branch = '1;
		aluControl_IJ = 6'b000011;
	end
	6'b000010:
	begin
		jump = '1;
	end
	6'b000011:
	begin
		jump = '1;
		pcToMem = '1;
	end
	default://NOP
	begin
		aluControl_IJ = 6'b111111;
	end
	endcase
end
endmodule
	