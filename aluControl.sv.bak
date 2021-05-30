//Determines the ALU operation on the controller op and funct
module aluControl (input logic [5:0] funct, input logic aluOp,
			output logic [5:0] aluControl_R, output logic alusrc_shift);

always_comb
begin
	alusrc_shift = '0;
	if(aluOp)//opcode is 000000 then the operation is dertermined by the funct of the instruction
	begin
		unique case (funct)
		6'b100000:
			aluControl_R = 6'b000000;//AND
		6'b100101:
			aluControl_R = 6'b000001;//OR
		6'b100100:
			aluControl_R = 6'b000010;//Add
		6'b100010:
			aluControl_R = 6'b000011;//Sub
		6'b101010:
			aluControl_R = 6'b000100;//slt
		6'b100111:
			aluControl_R = 6'b000101;//NOR
		6'b011000:
			aluControl_R = 6'b000110;//Mult	
		6'b011010:
			aluControl_R = 6'b000111;//Div
		6'b100110:
			aluControl_R = 6'b000111;//XOR
		6'b000000://Shift Left Logical
		begin
			aluControl_R = 6'b001000;
			alusrc_shift = '1;
		end
		6'b000001://Shift Left Arithmetic
		begin
			aluControl_R = 6'b001001;
			alusrc_shift = '1;
		end
		6'b000010://Shift Right Logical
		begin
			aluControl_R = 6'b001010;
			alusrc_shift = '1;
		end
		6'b000011://Shift Right Arithmetic
		begin
			aluControl_R = 6'b001011;
			alusrc_shift = '1;
		end
		6'b001000://Jump return, sets the PC to the address parsed.
		begin
			aluControl_R = 6'b111111;//ALU not needed
		end
		default:
			aluControl_R = 6'b111111;//NOP
		endcase
	end
	else//Should never go here so if it does tell it to do a no op
	begin
		aluControl_R = 6'b111111;
	end

end

endmodule
