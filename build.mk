TARGET  :=
VCD     := $(TARGET)_tb.vcd
VVP     := $(TARGET).vvp

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@ -O

.SUFFIXES: .nsl .hpp
.nsl.hpp:
	nsl2vl -systemc -o $@ $<

%.nsl: %.nh

.PHONY: $(TARGET)
$(TARGET): $(VCD)

vcd: $(VCD)
$(VCD): $(VVP)
	./$<

vvp: $(VVP)
$(VVP): $(TARGET)_tb.nsl $(TARGET).v $(REQUIRE_MODULES)
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@

verilator: $(TARGET)_tb.v $(TARGET).v $(REQUIRE_MODULES:.v=.nsl)
	verilator --cc $(TARGET)_tb.v --exe $(TARGET).cpp --trace
	make -j -C obj_dir -f V$(TARGET)_tb.mk V$(TARGET)_tb
	obj_dir/V$(TARGET)_tb

vwave: $(TARGET).vcd
	gtkwave $<

waveform: $(VCD)
	gtkwave $<

clean:
	rm -rf *.v *.vcd *.vvp
