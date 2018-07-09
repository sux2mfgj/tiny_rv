TARGET  :=
VCD     := $(TARGET)_tb.vcd
VVP     := $(TARGET).vvp
DUMP_FILE   := ../toolchain/share/riscv-tests/isa/$(notdir $(MEMORY_HEX:.hex=.dump))

.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl -neg_res $< -o $@ -O0 -canreadoutput -regreport

%.nsl: %.nh

.PHONY: $(TARGET)
$(TARGET): $(VCD)

vcd: $(VCD)
$(VCD): $(VVP)
	./$<

vvp: $(VVP)
$(VVP): $(TARGET)_tb.nsl $(TARGET).v $(REQUIRE_MODULES)
	nsl2vl -neg_res -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@

hex.nh: FORCE
	echo '#define MEMORY_HEX "$(MEMORY_HEX)"' > hex.nh

dummy_memory.v: hex.nh

veri: $(TARGET)_tb.v $(TARGET).v $(REQUIRE_MODULES)
	sed s/XXXXX/$(TARGET)/g ../template_cpp > $(TARGET).cpp
	verilator --cc $(TARGET)_tb.v $(REQUIRE_MODULES) --exe $(TARGET).cpp --trace --trace-underscore
	make -j -C obj_dir -f V$(TARGET)_tb.mk V$(TARGET)_tb
	obj_dir/V$(TARGET)_tb

dump:
	less $(DUMP_FILE)

vwave: $(TARGET).vcd
	gtkwave $<

waveform: $(VCD)
	gtkwave $<

FORCE:
