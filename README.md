# RISC-V-isa-based-3-stage-pipelined-ALU-design

# Overview
This project implements a 3-stage pipelined Arithmetic Logic Unit (ALU) based on the RISC-V Instruction Set Architecture (ISA). The design aims to optimize performance by utilizing a pipeline architecture that divides the ALU operations into three distinct stages: Fetch, Decode, and Execute. This allows for improved throughput by processing multiple instructions concurrently.

- Features
3-Stage Pipeline: The ALU is divided into three stages—Fetch, Decode, and Execute—to enhance processing speed.
RISC-V ISA: Supports a subset of RISC-V instructions for basic arithmetic and logical operations.
Hazard Detection: Incorporates basic data hazard detection and forwarding mechanisms to maintain pipeline efficiency.
Verilog Implementation: The design is implemented in Verilog HDL, making it suitable for synthesis on FPGA or ASIC platforms.
Testbench Included: A comprehensive testbench is provided to validate the functionality of the ALU.
Pipeline Stages
Fetch (IF)

Instruction is fetched from memory.
Program Counter (PC) is updated.
Decode (ID)

Instruction is decoded to identify the operation and operands.
Control signals are generated.
Execute (EX)

The actual arithmetic or logical operation is performed.
Result is computed and forwarded to the next stage or written back.
