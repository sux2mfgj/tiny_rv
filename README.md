Tiny RISC-V Implementation
---
[![CircleCI](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master.svg?style=svg)](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master)

### Instructions
#### RV32I
list of opcodes.
##### Op-IMM
- [x] ADDI
- [ ] SLTI
- [ ] SLTIU
- [ ] ANDI
- [ ] ORI
- [ ] XORI
- [ ] SLLI
- [ ] SRLI
- [ ] SRAI

##### LUI
- [ ] LUI

##### AUIPC
- [ ] AUIPC

##### OP
- [x] ADD
- [ ] SLT
- [ ] SLTU
- [ ] AND
- [ ] OR
- [ ] XOR
- [ ] SLL
- [ ] SRL
- [ ] SUB
- [ ] SRA

##### JAL
- [x] JAL

##### JALR
- [x] JALR

##### BRANCH
- [x] BEQ
- [x] BNE
- [x] BLT
- [ ] BLTU
- [x] BGE
- [ ] BGEU

##### LOAD
- [ ] LOAD

##### STORE
- [ ] STORE

##### MISC-MEM
- [ ] FENCE.I

##### SYSTEM
- [ ] CSRRW
- [ ] CSRRS
- [ ] CSRRC
- [ ] CSRRWI
- [ ] CSRRSI
- [ ] CSRRCI
- [ ] PRIV(ECALL)
- [ ] PRIV(EBREAK)

### Prepare gcc for RV32I
```
$ make prepare_toolchain
```  
or
```
$ docker pull himaaaatti/rv32i_tools
```

### TODO
- [ ] test
- [ ] CI for test
