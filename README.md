# RISC-V Out-of-Order (OoO) Processor

## Overview

This repository contains the design and implementation of a high-performance RISC-V Out-of-Order (OoO) processor core. The OoO core dynamically schedules and executes instructions out of program order to maximize instruction-level parallelism (ILP) while maintaining program correctness through precise state management.

The processor supports standard RISC-V 32-bit/64-bit ISA extensions and incorporates advanced microarchitectural features such as register renaming, reorder buffer (ROB), speculative execution with branch prediction, and dynamic scheduling.

## Key Features

- **Out-of-Order Execution:** Enables instructions to be executed as soon as their operands are ready, improving pipeline utilization and performance.
- **Register Renaming:** Eliminates false data dependencies by mapping architectural registers to a larger set of physical registers.
- **Reorder Buffer (ROB):** Ensures instructions commit in program order for precise exceptions and correct architectural state updates.
- **Speculative Execution & Branch Prediction:** Minimizes pipeline stalls by predicting control flow and recovering from mispredictions efficiently.
- **Support for RISC-V ISA:** Implements RV32I/RV64I base integer instruction sets with optional extensions (customizable).
- **Modular & Parameterized Design:** Allows easy customization and extension for academic research, performance evaluation, or hardware prototyping.
- **Verification Infrastructure:** Includes testbenches and simulation scripts to verify functional correctness and performance.

## Applications

- Microarchitecture research and teaching on out-of-order processor design.
- Benchmarking and performance analysis of RISC-V OoO implementations.
- Development platform for custom ISA extensions and accelerator integration.
- Foundation for FPGA prototyping or ASIC implementation of advanced RISC-V cores.



