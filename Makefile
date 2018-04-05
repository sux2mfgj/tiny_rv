
decode.nsl: decode.nh
decode: decode.v


.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<


decode: decode.v decode_tb.nsl execute_dumy.v
	nsl2vl -verisim2 decode_tb.nsl -target decode_tb
	iverilog decode.v decode_tb.v execute_dumy.v

RVGCC   := toolchain/riscv32-unknown-elf-gcc

prepare_toolchain: $(RVGCC)
$(RVGCC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-arch=rv32i --with-guile=no
	cd build; make -j $(shell nproc)

