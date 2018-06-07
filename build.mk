TARGET  :=
REQUIRE_MODULES :=

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $< -o $@

%.nsl: %.nh

.PHONY: $(TARGET)
$(TARGET): $(TARGET)_tb.nsl $(TARGET).v
	nsl2vl -verisim2 $< -target $(basename $<)
#nsl2vl -verisim2 $< -target $(TARGET)_tb -o $(TARGET)_tb.v
	iverilog $(addsuffix .v, $(basename $^)) $(REQUIRE_MODULES) -o $@.vcd
#iverilog $< $(REQUIRE_MODULES) -o $@.vcd
	./$@.vcd

clean:
	rm -rf *.v *.vcd
