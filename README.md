# 5-Stage Pipelined Processor

### Objective
The objective of this project is to design and implement a simple 5-stage pipelined processor, following von Neumann architecture.

### Introduction
The processor in this project adheres to a RISC-like instruction set architecture with the following features:

- Eight 4-byte general-purpose registers: R0 through R7.
- Two specific registers: PC (Program Counter) and SP (Stack Pointer).
- Initial SP value is set to (2^12-1).
- Memory address space is 4 KB with 16-bit word width (1 word = 2 bytes).
- Data bus width is 16 bits for instruction memory and 32 bits for data memory.

### ISA Specification
The Instruction Set Architecture (ISA) for this processor is RISC-like, encompassing instructions such as:

### One Operand Instructions

| Mnemonic | Function                            |
|----------|-------------------------------------|
| NOP      | PC ← PC + 1                        |
| NOT Rdst | R[Rdst] ← 1’s Complement(R[Rdst])   |
| NEG Rdst | R[Rdst] ← 0 - R[Rdst]               |
| INC Rdst | R[Rdst] ← R[Rdst] + 1               |
| DEC Rdst | R[Rdst] ← R[Rdst] – 1               |
| OUT Rdst | OUT.PORT ← R[Rdst]                  |
| IN Rdst  | R[Rdst] ← IN.PORT                   |

### Two Operands Instructions

| Mnemonic       | Function                                     |
|----------------|----------------------------------------------|
| SWAP Rsrc, Rdst | R[Rdst] ← R[Rsrc], R[Rsrc] ← R[Rdst]         |
| ADD Rdst, Rsrc1, Rsrc2 | R[Rdst] ← R[Rsrc1] + R[Rsrc2]          |
| ADDI Rdst, Rsrc1, Imm  | R[Rdst] ← R[Rsrc1] + Imm               |
| SUB Rdst, Rsrc1, Rsrc2 | R[Rdst] ← R[Rsrc1] - R[Rsrc2]          |
| AND Rdst, Rsrc1, Rsrc2 | R[Rdst] ← R[Rsrc1] AND R[Rsrc2]        |
| OR Rdst, Rsrc1, Rsrc2  | R[Rdst] ← R[Rsrc1] OR R[Rsrc2]         |
| XOR Rdst, Rsrc1, Rsrc2 | R[Rdst] ← R[Rsrc1] XOR R[Rsrc2]        |
| CMP Rsrc1, Rsrc2       | Compare R[Rsrc1] and R[Rsrc2]         |
| BITSET Rdst, Imm       | Set the bit specified by Imm value in Rdst |
| RCL Rsrc, Imm          | Rotate (with carry) left Rsrc by Imm bits |
| RCR Rsrc, Imm          | Rotate (with carry) right Rsrc by Imm bits|

### Memory Operations

| Mnemonic  | Function                                      |
|-----------|-----------------------------------------------|
| PUSH Rdst | M[SP--] ← R[Rdst]                             |
| POP Rdst  | R[Rdst] ← M[++SP]                             |
| LDM Rdst, Imm | R[Rdst] ← {0, Imm<15:0>}                    |
| LDD Rdst, EA   | R[Rdst] ← M[EA]                              |
| STD Rsrc, EA   | M[EA] ← R[Rsrc]                              |
| PROTECT Rsrc   | Protects memory location pointed at by Rsrc  |
| FREE Rsrc      | Frees a protected memory location pointed at by Rsrc and resets its content |

### Branch Operations

| Mnemonic | Function                                         |
|----------|--------------------------------------------------|
| JZ Rdst  | Jump if zero                                     |
| JMP Rdst | Jump                                             |

For additional ISA information, please refer to the provided documentation.

### Implementation Details
The processor is implemented in VHDL, a hardware description language. Additionally, the project includes an assembler to convert assembly code to machine code compatible with the processor's ISA.

