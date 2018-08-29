clean:
	rm -rf *.v *.vcd *.vvp *.cpp obj_dir/ hex.nh

TARGET  :=
MEMORY_HEX  := ../hexs/rv32ui-p-add.hex

HEXS    := $(shell ls ../hexs/*)

ifeq ($(TARGET), csr_manager)
    REQUIRE_MODULES := control_status_registers.v
endif

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v integer_register.v integer_arithmetic_logic.v control_status_registers.v csr_manager.v
endif

#riscv-test: FORCE
#	echo '' > riscv_test_result
#	for hex in $(HEXS); do \
#        make TARGET=test_system MEMORY_HEX=$$hex veri; if [ $$? -eq 0 ]; then \
#            echo "[ passed ] $$hex" >> riscv_test_result; \
#        else \
#            echo "[ failed ] $$hex" >> riscv_test_result; \
#        fi \
#	done
#	cat riscv_test_result

ifdef TARGET
    include ../build.mk
else
FORCE:
endif
