RV_PATH := $(CURDIR)/toolchain/bin
RV_GCC  := riscv32-unknown-elf-gcc
CC      := $(RV_PATH)/$(RV_GCC)
export PATH += :$(RV_PATH)

all:

prepare_toolchain: $(CC)
$(CC):
	mkdir -p toolchain
	mkdir -p build
	cd build; ../riscv-gnu-toolchain/configure --prefix=$(shell pwd)/toolchain --with-guile=no
	cd build; make -j $(shell nproc)

riscv_test: clean
	mkdir test_build
	cd test_build; CC=../toolchain/bin/riscv64-unknown-elf-gcc ../riscv-tests/configure --prefix=/home/hima/work/tiny_rv/build/../toolchain/
	cd test_build; make -j $(shell nproc); make install

clean:
	rm -fr *.v *.vcd a.out build *.o *.mem test_build
	make -C core clean
