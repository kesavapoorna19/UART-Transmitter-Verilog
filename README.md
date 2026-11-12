# UART Transmitter Using Verilog HDL

## 1. Project Overview

This project implements a basic UART (Universal Asynchronous Receiver/Transmitter) transmitter using Verilog HDL.

The design transmits 8-bit parallel data serially through a single TX output line.

## 2. Features

- UART transmitter design using Verilog HDL
- 8-bit data transmission
- Start bit and stop bit generation
- Least Significant Bit (LSB) first transmission
- Finite State Machine (FSM) based architecture
- Verilog testbench for functional simulation

## 3. UART Frame Format

The transmitter uses the following frame structure:

- 1 Start bit (LOW)
- 8 Data bits
- 1 Stop bit (HIGH)

## 4. FSM States

The design uses five states:

| State | Description |
|---|---|
| IDLE | Waits for transmission request |
| START | Sends start bit |
| DATA | Sends 8 data bits |
| STOP | Sends stop bit |
| DONE | Completes transmission |

## 5. Project Files

- `uart_tx.v` – UART transmitter RTL design.
- `tb_uart_tx.v` – Testbench for the transmitter.
- `RTL_uart_tx.pdf` – Reference design document.
- `wave_tb_uart_tx.png` – Reference waveform image.

## 6. Design Parameters

- Data width: 8 bits
- Clock: 100 MHz (testbench)
- Baud timing: 16 clock cycles per bit

## 7. Tools and Technologies

- Verilog HDL
- RTL Design
- Finite State Machine (FSM)
- Testbench-based verification

## 8. Original Source and Attribution

This repository is based on an existing UART transmitter project.

Original source: https://github.com/Huichingchang/uart_tx_test

Credit goes to the original author. This repository is shared for learning and educational purposes.

## 9. Learning Outcomes

- Understanding UART serial communication
- Learning Verilog RTL coding
- Understanding FSM-based digital design
- Understanding Verilog testbench structure
