# usb-crc16-systemverilog
SystemVerilog implementation of a USB CRC16 generator using an LFSR architecture. Designed for FPGA-based digital communication systems with synchronous bit-by-bit CRC calculation

# USB CRC16 SystemVerilog

This project implements a USB CRC16 generator using SystemVerilog.

## Features

- LFSR-based CRC16 calculation
- Bit-by-bit serial message input
- Synchronous FPGA implementation
- Ready signal generation after message processing

## Interface

Inputs:
- clk_48MHz : FPGA clock
- rst       : Active high reset
- init_crc  : Initialize CRC calculation
- msg_bit   : Serial message bit
- msg_bit_rdy : Indicates valid message bit

Outputs:
- crc16_out : 16-bit CRC result
- crc16_rdy : CRC calculation complete flag

## Architecture

The CRC calculation is implemented using a Linear Feedback Shift Register (LFSR).

Polynomial:

CRC-16-USB:

## Tools

- SystemVerilog
- Vivado / Quartus
- FPGA implementation
