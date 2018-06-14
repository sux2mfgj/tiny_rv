tiny risc-v (rv32i) implementation written in NSL
---
[![CircleCI](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master.svg?style=svg)](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master)

##### Requirements to build & test
- NSL
- iverilog
- gtkwave
- verilator

##### TODO
- ~~fix dummy_memory for riscv-test~~
- ふぃぼなっち
- for FPGA
    - AXI-slave-LED
    - AXI-master
    - bootrom  
        https://timetoexplore.net/blog/initialize-memory-in-verilog
    - UART
    - Linux
- rv6 on tiny_rv
- web interface

##### MEMO
```
$ cd core
$ make hex.nh TARGET=test_system MEMORY_HEX=../rv32ui-p-and.hex
```
