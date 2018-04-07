RV_PATH := toolchain/bin/
CC      := $(RV_PATH)/riscv32-unknown-elf-gcc
OBJDUMP := $(RV_PATH)/riscv32-unknown-elf-objdump

decode.nsl: decode.nh
decode: decode.v


.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<


decode: decode.v decode_tb.nsl
	nsl2vl -verisim2 decode_tb.nsl -target decode_tb
	iverilog decode.v decode_tb.v
	./a.out

ifetch: inst_fetch.v inst_fetch_tb.nsl
	nsl2vl -verisim2 inst_fetch_tb.nsl -target inst_fetch_tb
	iverilog inst_fetch.v inst_fetch_tb.v

mem_ifetch: inst_fetch.v test_memory.v mem_ifetch_tb.nsl
	nsl2vl -verisim2 mem_ifetch_tb.nsl -target mem_ifetch_tb
	iverilog inst_fetch.v test_memory.v mem_ifetch_tb.v
	./a.out

ipu: ipu.v ipu_tb.nsl
	nsl2vl -verisim2 ipu_tb.nsl -target ipu_tb
	iverilog ipu.v ipu_tb.v
	./a.out

exec: ipu.v decode.v execute.v execute_tb.nsl
	nsl2vl -verisim2 execute_tb.nsl -target execute_tb
	iverilog ipu.v decode.v execute.v execute_tb.v
	./a.out

tiny_rv: tiny_rv.v inst_fetch.v test_memory.v tiny_rv_tb.nsl # decode.v
	nsl2vl -verisim2 tiny_rv_tb.nsl -target tiny_rv_tb
	iverilog tiny_rv.v inst_fetch.v test_memory.v tiny_rv_tb.v
	./a.out

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
