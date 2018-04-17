Tiny RISC-V Implementation
---
[![CircleCI](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master.svg?style=svg)](https://circleci.com/gh/sux2mfgj/tiny_rv/tree/master)

### Instructions
- RV32I
[current status](./instructions.md)

### Prepare gcc for RV32I
```
$ make prepare_toolchain
```  
or
```
$ docker pull himaaaatti/rv32i_tools
```

### Generate memory dump for readmemh (for verilog)
using [elf_dump](https://github.com/sux2mfgj/elf_dump)

### TODO
- [ ] test
- [x] CI for test
