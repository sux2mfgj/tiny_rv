RV_PATH := toolchain/bin/
CC      := $(RV_PATH)/riscv32-unknown-elf-gcc
OBJDUMP := $(RV_PATH)/riscv32-unknown-elf-objdump

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<

build_mem: main.s
	$(CC) -c $<
	$(OBJDUMP) -D main.o | awk '{if(NR>=8){ printf "32\x27h%s, ",$$2} }' > test.mem


prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)

clean:
	rm -fr *.v *.vcd a.out build
