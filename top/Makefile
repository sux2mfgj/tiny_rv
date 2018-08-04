TARGET := top

ifeq ($(TARGET), top)
	REQUIRE_MODULES := ../bus_arbiter_with_rom/bus_arbiter_with_rom.v ../bus_arbiter_with_rom/bootrom.v ../core/tiny_rv.v ../core/opcode_system.v ../core/integer_arithmetic_logic.v ../core/integer_register.v ../core/fetch.v ../nsl_axi4_lite/axi4_lite_master.v
endif

include ../build.mk

clean:
	rm -rf *.v *.vcd *.vvp *.cpp obj_dir/ hex.nh
