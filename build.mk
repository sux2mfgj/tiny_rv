TARGET  :=
#REQUIRE_MODULES :=

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@

%.nsl: %.nh

.PHONY: $(TARGET)
$(TARGET): $(TARGET).vcd

vcd: $(TARGET)_tb.vcd
$(TARGET)_tb.vcd: $(TARGET).vvp
	./$<

vvp: $(TARGET).vvp
$(TARGET).vvp: $(TARGET)_tb.nsl $(TARGET).v $(REQUIRE_MODULES)
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@

waveform: $(TARGET)_tb.vcd
	gtkwave $<

clean:
	rm -rf *.v *.vcd
