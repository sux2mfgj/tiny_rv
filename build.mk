TARGET  :=
VCD     := $(TARGET)_tb.vcd
VVP     := $(TARGET).vvp

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@

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

waveform: $(VCD)
	gtkwave $<

clean:
	rm -rf *.v *.vcd *.vvp
