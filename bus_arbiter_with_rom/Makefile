TARGET	:=

ifeq ($(TARGET), bus_arbiter_with_rom)
	REQUIRE_MODULES	:= ../nsl_axi4_lite/axi4_lite_master.v
endif

clean:
	rm -rf *.v *.vcd *.vvp *.cpp obj_dir/ hex.nh

ifdef TARGET
    include ../build.mk
endif
