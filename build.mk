TARGET  :=

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<

%.nsl: %.nh

$(TARGET): $(TARGET)_tb.nsl $(TARGET).v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@.vcd
	./$@.vcd

clean:
	rm -rf *.v *.vcd
