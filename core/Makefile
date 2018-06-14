clean:
	rm -rf *.v *.vcd *.vvp obj_dir/ hex.nh

TARGET  :=
MEMORY_HEX  := ../hexs/rv32ui-p-add.hex

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v integer_register.v integer_arithmetic_logic.v control_status_registers.v
endif

ifeq ($(TARGET), dummy_arbiter)
    REQUIRE_MODULES := dummy_memory.v
endif

ifeq ($(TARGET), test_system)
    REQUIRE_MODULES := tiny_rv.v fetch.v integer_register.v integer_arithmetic_logic.v dummy_arbiter.v dummy_memory.v opcode_system.v
endif

ifdef TARGET
    include ../build.mk
endif
