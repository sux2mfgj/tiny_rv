RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)
DUMP        := elf_dump/target/release/elf_dump

.SUFFIXES: .s .elf
.s.elf:
	$(RV32I_DOCKER) $(RVGCC) $< -o $(basename $<).elf -T linker.ld -nostdlib -nostdinc

.SUFFIXES: .elf .mem
.elf.mem: ./$(DUMP)
	./$(DUMP) $(basename $<).elf > $@

%.mem: %.elf $(DUMP)

$(DUMP):
	make -C elf_dump release
