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

fetch: fetch.v fetch_tb2.nsl
	nsl2vl -verisim2 fetch_tb2.nsl -target fetch_tb2
	iverilog fetch.v fetch_tb2.v
	./a.out

regs: integer_register.v integer_register_tb.nsl
	nsl2vl -verisim2 integer_register_tb.nsl -target integer_register_tb
	iverilog integer_register.v integer_register_tb.v
	./a.out

build_mem_docker: main.s
	$(RV32I_DOCKER) $(RVGCC) -c main.s
	$(RV32I_DOCKER) $(RVOBJDUMP) -D main.o

build_mem: main.s
	$(CC) -c $<
#$(OBJDUMP) -D main.o | awk '{if(NR>=8){ print $$2} }' > test.mem
	$(OBJDUMP) -D main.o | awk '{if($$2 ~/^[0-f]+$$/) print $$2}' > test.mem


ialu: integer_arithmetic_logic.v integer_arithmetic_logic_tb.nsl
	nsl2vl -verisim2 integer_arithmetic_logic_tb.nsl -target integer_arithmetic_logic_tb
	iverilog integer_arithmetic_logic.v integer_arithmetic_logic_tb.v
	./a.out

dummy_mem: dummy_memory.v dummy_memory_tb.nsl
	nsl2vl -verisim2 dummy_memory_tb.nsl -target dummy_memory_tb
	iverilog dummy_memory.v dummy_memory_tb.v
	./a.out

tiny_rv: tiny_rv.v dummy_memory.v tiny_rv_tb.nsl fetch.v integer_arithmetic_logic.v integer_register.v
	nsl2vl -verisim2 tiny_rv_tb.nsl -target tiny_rv_tb
	iverilog tiny_rv.v dummy_memory.v tiny_rv_tb.v fetch.v integer_arithmetic_logic.v integer_register.v
	./a.out

prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)

clean:
	rm -fr *.v *.vcd a.out build
