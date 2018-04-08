RV_PATH := toolchain/bin/
CC      := $(RV_PATH)/riscv32-unknown-elf-gcc
OBJDUMP := $(RV_PATH)/riscv32-unknown-elf-objdump

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

build_mem: main.s
	$(CC) -c $<
	$(OBJDUMP) -D main.o | awk '{if(NR>=8){ printf "32\x27h%s, ",$$2} }' > test.mem

tiny_rv: tiny_rv.v dummy_memory.v tiny_rv_tb.nsl fetch.v
	nsl2vl -verisim2 tiny_rv_tb.nsl -target tiny_rv_tb
	iverilog tiny_rv.v dummy_memory.v tiny_rv_tb.v fetch.v
	./a.out


prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)

clean:
	rm -fr *.v *.vcd a.out build
