# APB Slave Design & Verification using SystemVerilog

A complete SystemVerilog design and verification project for an AMBA APB Slave featuring FSM-based RTL design, directed and constrained-random transactions, mailbox-based communication, self-checking scoreboard, SystemVerilog Assertions (SVA), and waveform-based verification.

---

## 📌 Project Overview

This project implements and verifies an APB Slave with a 16 × 8-bit internal memory using a custom SystemVerilog verification environment.

The design supports APB read and write transactions with address validation, error detection, and appropriate PREADY and PSLVERR generation.

The verification environment includes:

- Directed read/write test scenarios
- Constrained-random transaction generation
- Generator, Driver, Monitor and Scoreboard
- Mailbox-based communication
- Self-checking scoreboard
- SystemVerilog Assertions (SVA)
- Functional verification
- Protocol compliance checking
- Waveform-based debugging

---

# Repository Structure

```text
APB-Slave-Verification/
│
├── apb_slave.sv
├── apb_interface.sv
├── transaction.sv
├── generator.sv
├── driver.sv
├── monitor.sv
├── scoreboard.sv
├── environment.sv
├── apb_assertions.sv
├── testbench.sv
│
├── apb_write_waveform.png
├── apb_read_waveform.png
│
└── README.md
```
## Verification Environment

The custom verification environment consists of the following components:

#### Transaction
- Defines APB transaction-level data.
- Contains address, write data, read data and control information.
- Supports constrained-random address and data generation.
#### Generator
- Generates directed APB read/write test scenarios.
- Includes write, read, overwrite and read-after-write tests.
- Performs constrained-random stress testing.
- Sends transactions to the driver through a mailbox.
#### Driver
- Converts transactions into APB signal-level activity.
- Drives SETUP and ACCESS phases.
- Handles both read and write transactions.
- Controls PSEL, PENABLE, PWRITE, PADDR and PWDATA.
#### Monitor
- Observes APB interface activity.
- Captures completed transactions when PREADY is asserted.
- Sends monitored transaction information to the scoreboard.
Scoreboard
- Maintains a reference memory model.
- Stores expected data for write transactions.
- Compares read data against expected memory contents.
- Reports data matches and mismatches automatically.
Environment
- Instantiates and connects all verification components.
- Manages mailboxes and synchronization events.
- Controls reset, test execution and final result reporting.

## SystemVerilog Assertions (SVA)

The following APB protocol and functional properties are implemented:

- PENABLE asserted only when PSEL is active
- PREADY asserted only during a valid APB transaction
- Address remains stable during ACCESS phase
- Write data remains stable during ACCESS phase
- PSLVERR asserted only during a valid transaction
- Write transaction completes correctly
- Read transaction completes correctly
- SETUP phase transitions to ACCESS phase
- PREADY deassertion after transaction completion

Assertions are disabled during reset using disable iff.

## APB Signals Verified
#### APB Control Signals
- PSEL
- PENABLE
- PWRITE
- PREADY
- PSLVERR
  
#### APB Address & Data Signals

- PADDR
- PWDATA
- PRDATA
  
#### Clock & Reset

- PCLK
- PRESETn
  
### Test Scenarios
The testbench includes both directed and constrained-random scenarios:
#### Directed Tests
- Write data to address 5
- Read data from address 5
- Write data to address 7
- Read data from address 7
- Overwrite existing data
- Read overwritten data
- Constrained-Random Testing
- Random APB addresses within the valid memory range
- Random 8-bit write data
- Random read/write operations
- Multiple transactions for stress testing

## Verification Flow
```
Transaction
     │
     ▼
 Generator
     │
     ▼
  Mailbox
     │
     ▼
  Driver
     │
     ▼
 APB Slave DUT
     │
     ▼
  Monitor
     │
     ▼
  Scoreboard
     │
     ▼
PASS / FAIL
```
SVA assertions independently monitor protocol correctness during simulation.

# Simulation Waveforms

The project includes waveform analysis for APB read and write transactions.

The waveforms demonstrate:

- APB clock and reset
- SETUP phase
- ACCESS phase
- PSEL and PENABLE sequencing
- Read/write control
- Address and data activity
- PREADY response
- PSLVERR status
- Multiple APB transactions

### Features
- Synthesizable APB Slave RTL
- FSM-based APB control
- 16 × 8-bit internal memory
- APB read/write support
- Directed test scenarios
- Constrained-random verification
- Mailbox-based communication
- Self-checking scoreboard
- SystemVerilog Assertions
- Protocol verification
- Waveform-based debugging
- Modular SystemVerilog testbench
### Tools Used
- Verilog / SystemVerilog
- QuestaSim / ModelSim
- EPWave / GTKWave

## Author

##### Shreya Sharma

Electronics & Communication Engineering

Skills: RTL Design • Verilog • SystemVerilog • Design Verification • APB • SVA • Digital Design • FPGA • VLSI
