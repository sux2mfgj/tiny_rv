RV_PATH := ../../toolchain/bin
CC      := $(RV_PATH)/riscv64-unknown-elf-gcc
LD      := $(RV_PATH)/riscv64-unknown-elf-ld
OBJDUMP := $(RV_PATH)/riscv64-unknown-elf-objdump

build:
	$(CC) -mabi=ilp32 -march=rv32i -c led.c
	$(CC) -mabi=ilp32 -march=rv32i -c start.s
	$(LD) -mabi=ilp32 -march=rv32i -T led.ld -o led -melf32lriscv -static led.o start.o

dump:
	$(OBJDUMP) -D led.o
	$(OBJDUMP) -D start.o
	$(OBJDUMP) -D led

clean:
	rm -rf led *.o
