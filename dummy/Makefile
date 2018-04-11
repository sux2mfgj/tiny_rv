RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)

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

build_mem: test.mem
test.mem: build_obj dump_obj
build_obj: main.s
	$(RV32I_DOCKER) $(RVGCC) main.s -o main.o -T linker.ld -nostdlib -nostdinc
dump_obj:
	$(RV32I_DOCKER) $(RVOBJDUMP) -D main.o #TODO write hex

clean:
	rm -rf a.out *.v *.vcd *.o
