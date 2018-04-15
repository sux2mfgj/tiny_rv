RV_PATH := toolchain/bin/
RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC      := $(RV_PATH)/$(RVGCC)
OBJDUMP := $(RV_PATH)/$(RVOBJDUMP)
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<

build_mem_docker: main.s
	$(RV32I_DOCKER) $(RVGCC) main.s -o a.out -T linker.ld -nostdlib -nostdinc

dump_docker:
	$(RV32I_DOCKER) $(RVOBJDUMP) -D a.out #-D a.out

build_mem: main.s
	$(CC) -c $<
#$(OBJDUMP) -D main.o | awk '{if(NR>=8){ print $$2} }' > test.mem
	$(OBJDUMP) -D main.o | awk '{if($$2 ~/^[0-f]+$$/) print $$2}' > test.mem

dummies:
	make -C dummy all

tiny_rv: tiny_rv.v tiny_rv_tb.nsl fetch.v integer_arithmetic_logic.v integer_register.v dummies
	nsl2vl -verisim2 tiny_rv_tb.nsl -target tiny_rv_tb
	iverilog tiny_rv.v tiny_rv_tb.v fetch.v integer_arithmetic_logic.v integer_register.v dummy/memory.v
	./a.out

prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)

clean:
	rm -fr *.v *.vcd a.out build *.o
	make -C dummy clean
