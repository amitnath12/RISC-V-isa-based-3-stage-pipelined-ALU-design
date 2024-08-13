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

- Instruction	   Funct3	    Funct7.
- ADD	            000	     0000000.
- SUB	            000	     0100000.
SLL           	001	     0000000.
SLT	            010	     0000000.
SLTU	          011	     0000000.
XOR	            100	     0000000.
SRL	            101    	 0000000.
SRA	            101	     0100000.
OR	            110	     0000000.


