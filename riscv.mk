RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)
#ELF_DUMP    := elf_dump/target/release/elf_dump

.SUFFIXES: .s .elf
.s.elf:
	$(RV32I_DOCKER) $(RVGCC) $< -o $(basename $<).elf -T linker.ld -nostdlib -nostdinc

%.mem: %.elf $(ELF_DUMP)

$(ELF_DUMP):
	make -C elf_dump release
