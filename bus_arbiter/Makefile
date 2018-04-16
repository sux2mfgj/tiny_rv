include ../riscv.mk

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@

%.nsl: %.nh

bus_arbiter: bus_arbiter_tb.nsl bus_arbiter.v memory.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) $(REQUIRE_MODULES) -o $@.vvp
	./$@.vvp

memory.v: test.mem
memory: memory_tb.nsl memory.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) $(REQUIRE_MODULES) -o $@.vvp
	./$@.vvp

test.mem: main.elf
	../$(ELF_DUMP) $< > $@

dump: main.elf
	$(RV32I_DOCKER) $(RVOBJDUMP) -D $<

clean:
	rm -rf *.v *.vcd *.vvp *.elf test.mem

#include ../build.mk
