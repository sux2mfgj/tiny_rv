RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)
DUMP        := elf_dump
DUMP_URL    := https://github.com/sux2mfgj/elf_dump/releases/download/v0.1.0/elf_dump

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<

all: arbiter mem build_mem

arbiter: bus_arbiter_tb.nsl bus_arbiter.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^))
	./a.out

#TODO: memory require test.mem
mem: memory_tb.nsl memory.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^))
	./a.out

test.mem: build_mem
build_mem: main.s $(DUMP)
	$(RV32I_DOCKER) $(RVGCC) main.s -o main.elf -T linker.ld -nostdlib -nostdinc
	./$(DUMP) main.elf > test.mem

dump_obj:
	$(RV32I_DOCKER) $(RVOBJDUMP) -D main.elf

$(DUMP):
	wget $(DUMP_URL)
	chmod +x $@

clean:
	rm -rf a.out *.v *.vcd *.o
