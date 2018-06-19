clean:
	rm -rf *.v *.vcd *.vvp obj_dir/ hex.nh

TARGET  :=
MEMORY_HEX  := ../hexs/rv32ui-p-add.hex

HEXS    := $(shell ls ../hexs/*)

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v integer_register.v integer_arithmetic_logic.v control_status_registers.v
endif

ifeq ($(TARGET), dummy_arbiter)
    REQUIRE_MODULES := dummy_memory.v
endif

ifeq ($(TARGET), test_system)
    REQUIRE_MODULES := tiny_rv.v fetch.v integer_register.v integer_arithmetic_logic.v dummy_arbiter.v dummy_memory.v opcode_system.v
endif

riscv-test: FORCE
	echo '' > riscv_test_result
	for hex in $(HEXS); do \
        make TARGET=test_system MEMORY_HEX=$$hex veri; if [ $$? -eq 0 ]; then \
            echo "[ passed ] $$hex" >> riscv_test_result; \
        else \
            echo "[ failed ] $$hex" >> riscv_test_result; \
        fi \
	done
	cat riscv_test_result

ifdef TARGET
    include ../build.mk
else
FORCE:
endif
