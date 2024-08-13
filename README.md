# RISC-V-isa-based-3-stage-pipelined-ALU-design

# Overview
This project implements a 3-stage pipelined Arithmetic Logic Unit (ALU) based on the RISC-V Instruction Set Architecture (ISA). The design aims to optimize performance by utilizing a pipeline architecture that divides the ALU operations into three distinct stages: Fetch, Decode, and Execute. This allows for improved throughput by processing multiple instructions concurrently.

# Features 
- 3-Stage Pipeline: The ALU is divided into three stages—Fetch, Decode, and Execute—to enhance processing speed.
- RISC-V ISA: Supports a subset of RISC-V R type and I type instructions for basic arithmetic and logical operations.
- Control Logic Unit: Decodes the incoming 32 bit instructions,and determines the intended operations the ALU is supposed to perform.
- ALU Unit: Performs the arithmatic and Logical operations as instructed.
- Verilog Implementation: The design is implemented in Verilog HDL, making it suitable for synthesis on FPGA or ASIC platforms.
# Pipeline Stages
- Fetch (IF): Instruction is fetched from memory.
- Decode (ID): Instruction is decoded to identify the operation and operands.
Control signals are generated.
- Execute (EX): The actual arithmetic or logical operation is performed.
Result is computed and forwarded to the next stage or written back.

# R-Type Instructions (Register-Register Operations)
Opcode: 0110011.

- ADD(Add): Funct3 == 000,Funct7 ==0000000.
- SUB(Subtract):	 Funct3 ==        000,Funct7 ==	     0100000.
- SLL(Shift Left Logical):  Funct3 ==         	001,Funct7 ==	     0000000.
- SLT(Set Less Than):	 Funct3 ==           010,Funct7 ==	     0000000.
- SLTU(Set Less Than Unsigned):	 Funct3 ==	          011,Funct7 ==	     0000000.
- XOR(XOR ):	 Funct3 ==	            100,Funct7 ==	     0000000.
- SRL(Shift Right Logical):	 Funct3 ==	            101,Funct7 ==    	 0000000.
- SRA(Shift Right Arithmetic):	 Funct3 ==	            101,Funct7 ==	     0100000.
- OR(OR):	 Funct3 ==	            110,Funct7 ==	     0000000.

# I-Type Instructions(Immidiate Operations)
opcode: 0010011:

- ADDI (Add Immediate): 000
- SLTI (Set Less Than Immediate): 010
- SLTIU (Set Less Than Immediate Unsigned): 011
- XORI (XOR Immediate): 100
- ORI (OR Immediate): 110
- ANDI (AND Immediate): 111
- SLLI (Shift Left Logical Immediate): 001
- SRLI (Shift Right Logical Immediate): 101 (with funct7 = 0000000)
- SRAI (Shift Right Arithmetic Immediate): 101 (with funct7 = 0100000)


