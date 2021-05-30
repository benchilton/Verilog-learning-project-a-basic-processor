//Define the registers 

`define zero 	5'b00000
`define at	5'b00001
`define v0 	5'b00010
`define v1	5'b00011
`define a0 	5'b00100
`define a1	5'b00101
`define a2 	5'b00110
`define a3	5'b00111
`define t0 	5'b01000
`define t1	5'b01001
`define t2 	5'b01010
`define t3	5'b01011
`define t4 	5'b01100
`define t5	5'b01101
`define t6 	5'b01110
`define t7	5'b01111
`define t8 	5'b11000
`define t9	5'b11001
`define s0 	5'b10000
`define s1	5'b10001
`define s2 	5'b10010
`define s3	5'b10011
`define s4 	5'b10100
`define s5	5'b10101
`define s6 	5'b10110
`define s7	5'b10111
`define s8	5'b11010
`define s9	5'b11011
`define gp	5'b11100
`define sp	5'b11101
`define fp	5'b11110
`define ra	5'b11111

//R Type:|opcode (6)|rs (6)|rt (6)|rd (6)|shamt (6)|funct (6)|
//I Type:|opcode (6)|rs (6)|rt (6)|immediate (16)|
//J Type:|opcode (6)|address (26)|

`define rtype	6'b000000
`define	unused	6'b000000
//R-Type
`define	ADD	6'b100100
`define	SUB	6'b100010
`define	MULT	6'b011000
`define DIV	6'b011010
`define AND	6'b100000
`define OR	6'b100101
`define NOR	6'b100111
`define	XOR	6'b100110
`define SLL	6'b000000
`define SLA	6'b000001
`define SRL	6'b000010
`define SRA	6'b000011
`define JR	6'b001000
//Non R-Type
`define	NOP	6'b111111
`define	ADDI	6'b001000
`define	ADDIU	6'b001001
`define	ANDI	6'b001100
`define	ORI	6'b001101
`define	XORI	6'b001110
`define	BEQ	6'b000100
`define	BNE	6'b000101
`define	BGEZ	6'b000001
`define	BGTZ	6'b000111
`define	BLEZ	6'b000110
`define	BLTZ	6'b000001
`define	J	6'b000010
`define	JAL	6'b000011












