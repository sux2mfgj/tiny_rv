RV_PATH := toolchain/bin/
RVGCC       := riscv32-unknown-elf-gcc
RVOBJDUMP   := riscv32-unknown-elf-objdump
CC      := $(RV_PATH)/$(RVGCC)
OBJDUMP := $(RV_PATH)/$(RVOBJDUMP)
CC_DOCKER   := himaaaatti/rv32i_tools
RV32I_DOCKER := docker run -v $(shell pwd):/work $(CC_DOCKER)
ELF_DUMP    := $(shell pwd)/elf_dump/target/release/elf_dump

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@

build_mem_docker: main.s
	$(RV32I_DOCKER) $(RVGCC) main.s -o a.out -T linker.ld -nostdlib -nostdinc

dump_docker:
	$(RV32I_DOCKER) $(RVOBJDUMP) -D a.out #-D a.out

build_mem: main.s
	$(CC) -c $<
#$(OBJDUMP) -D main.o | awk '{if(NR>=8){ print $$2} }' > test.mem
	$(OBJDUMP) -D main.o | awk '{if($$2 ~/^[0-f]+$$/) print $$2}' > test.mem

system: system_tb.nsl bus_arbiter/bus_arbiter.v bus_arbiter/memory.v core/fetch.v core/integer_arithmetic_logic.v core/integer_register.v core/tiny_rv.v core/csr.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) $(REQUIRE_MODULES) -o $@.vcd
	./$@.vcd

test.mem: bus_arbiter/main.s bus_arbiter/linker.ld
	make -C bus_arbiter test.mem
	cp bus_arbiter/test.mem .

system_vcd: system
	gtkwave system_tb.vcd


tiny_rv: tiny_rv.v tiny_rv_tb.nsl fetch.v integer_arithmetic_logic.v integer_register.v csr.v dummies
	nsl2vl -verisim2 tiny_rv_tb.nsl -target tiny_rv_tb
	iverilog tiny_rv.v tiny_rv_tb.v fetch.v integer_arithmetic_logic.v integer_register.v
	./a.out

prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
#	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-guile=no
	cd build; make -j $(shell nproc)

riscv_test: clean
	mkdir test_build
	cd test_build; CC=../toolchain/bin/riscv64-unknown-elf-gcc ../riscv-tests/configure --prefix=/home/hima/work/tiny_rv/build/../toolchain/
	cd test_build; make -j $(shell nproc)


clean:
	rm -fr *.v *.vcd a.out build *.o *.mem
	make -C core clean
	make -C bus_arbiter clean
