Tiny RISC-V Implementation
---

### Instructions
#### RV32I
list of opcodes.
##### Op-IMM
- [ ] ADDI
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
- [ ] ADD
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
- [ ] JAL

##### JALR
- [ ] JALR

##### BRANCH
- [ ] BEQ
- [ ] BNE
- [ ] BLT
- [ ] BLTU
- [ ] BGE

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




### Build gcc for RV32I
```
$ make prepare_toolchain
```


