# APB Slave RTL Design & Verification

A SystemVerilog-based APB Slave design and verification project implementing APB read/write transactions using FSM-based control logic and a transaction-based verification environment.

The project includes an APB Slave RTL design, SystemVerilog interface, class-based testbench, directed and randomized test scenarios, self-checking scoreboard, and SVA-based protocol assertions.

## Project Overview

The objective of this project is to design and verify a simple APB Slave that supports read and write accesses to a 16-location memory.

The APB Slave uses FSM-based control logic to manage the transaction flow and supports the standard APB phases:

- IDLE
- SETUP
- ACCESS

The verification environment generates APB transactions, drives them to the DUT, monitors responses, compares expected and actual data using a scoreboard, and checks protocol behavior using SystemVerilog Assertions.

## Features

### RTL Design

- FSM-based APB Slave control logic
- Supports APB read and write transactions
- 16-location internal memory
- 32-bit address input
- 8-bit read/write data
- PREADY generation for transaction completion
- PSLVERR generation for invalid transactions
- Address range checking
- Detection of invalid/X/Z address and data values
- Synchronous memory write operation
- Asynchronous active-low reset

### Verification Environment

- Transaction-based SystemVerilog testbench
- Generator, Driver, Monitor and Scoreboard architecture
- Mailbox-based communication between verification components
- Event-based synchronization between Generator, Driver and Scoreboard
- Directed functional test scenarios
- Constrained-random stress testing
- Self-checking scoreboard
- SVA-based APB protocol verification
- Waveform-based debugging using simulation tools

## APB Transaction Flow

The APB transaction follows the standard two-phase transfer after IDLE:

```text
                 IDLE
                   |
                 PSEL=1
                   |
                   v
                SETUP
             PENABLE=0
                   |
                   v
                ACCESS
             PENABLE=1
                   |
              PREADY=1
                   |
                   v
                 IDLE
