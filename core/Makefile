ifndef
    $(error Please set TARGET variable. ex. make vcd TARGET=fetch)
endif

ifeq ($(TARGET), tiny_rv)
    REQUIRE_MODULES := fetch.v
endif

include ../build.mk
