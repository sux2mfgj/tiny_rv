RV_PATH := toolchain/bin/
CC      := $(RV_PATH)/riscv32-unknown-elf-gcc
OBJDUMP := $(RV_PATH)/riscv32-unknown-elf-objdump

decode.nsl: decode.nh
decode: decode.v


.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<


decode: decode.v decode_tb.nsl execute_dumy.v
	nsl2vl -verisim2 decode_tb.nsl -target decode_tb
	iverilog decode.v decode_tb.v execute_dumy.v

ifetch: inst_fetch.v inst_fetch_tb.nsl
	nsl2vl -verisim2 inst_fetch_tb.nsl -target inst_fetch_tb
	iverilog inst_fetch.v inst_fetch_tb.v


build_mem: main.s
	$(CC) -c $<
	$(OBJDUMP) -D main.o | awk '{if(NR>=8){ printf "32\x27h%s, ",$$2} }' > test.mem


prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)
