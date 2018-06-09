clean:
	rm -rf *.v *.vcd *.vvp

TARGET  :=

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v integer_register.v integer_arithmetic_logic.v
endif

ifdef TARGET
    include ../build.mk
endif
