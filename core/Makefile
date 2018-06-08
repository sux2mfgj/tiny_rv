clean:
	rm -rf *.v *.vcd *.vvp

TARGET  :=
ifdef TARGET
    include ../build.mk
endif

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v
endif

