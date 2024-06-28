![LOGO](https://github.com/FaridMahmoudzadeh/Vector-Processor/assets/119705391/7effbad3-ed30-458a-9b97-34472f439132)

# Vector Processor

This project implements a custom 512-bit vector processor using Verilog. The processor consists of three main components: a register file, an ALU (Arithmetic Logic Unit), and a memory module; and it supports 4 general instructions.

## Parts Overview
### Register File:
- Stores four 512-bit vectors (A1, A2, A3, and A4).
- Provides read and write ports for vector manipulation.
### ALU:
- Performs addition and multiplication operations.
- Inputs: A1 and A2; Outputs: A3 (low value) and A4 (high value).
### Memory:
- 512x32 memory with load and store instructions.
- Supports loading from memory into registers and vice versa.

## Instruction Set
- Load from memory
- Store to memory
- Addition
- Multiplication

## Tools
- Verilog HDL: a Hardware Description Language used to model electronic systems
- ModelSim: a multi-language environment for simulation of HDLs

## Implementation Details
The full implementation details are discussed thoroughly in the *Project Report.pdf* file located in the *Document* directoery

## How to Simulate
To simulate the project first we need to compile our VerilogHDL files and then simulate the TESTBENCH module using ModelSim.
[Here](https://nandland.com/introduction-to-modelsim-for-beginners/)'s a link that can teach you how to simulate modules in ModelSim.
