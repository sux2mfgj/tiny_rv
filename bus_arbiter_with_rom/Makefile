TARGET	:=

ifeq ($(TARGET), bus_arbiter_with_rom)
	REQUIRE_MODULES	:= bootrom.v ../nsl_axi4_lite/axi4_lite_master.v
endif

ifdef TARGET
    include ../build.mk
endif

clean:
	rm -rf bus_arbiter_with_rom_tb.v bus_arbiter_with_rom.v *.vcd *.vvp *.cpp obj_dir/ hex.nh

