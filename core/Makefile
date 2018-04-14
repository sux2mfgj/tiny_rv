.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<

%.nsl: %.nh

fetch: fetch_tb.nsl fetch.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@.vcd
	./$@.vcd

reg_file: integer_register_tb.nsl integer_register.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@.vcd
	./$@.vcd

ialu: integer_arithmetic_logic_tb.nsl integer_arithmetic_logic.v
	nsl2vl -verisim2 $< -target $(basename $<)
	iverilog $(addsuffix .v, $(basename $^)) -o $@.vcd
	./$@.vcd

#tiny_rv: tiny_rv_tb.nsl tiny_rv.v fetch.v integer_arithmetic_logic.v integer_register.v
#	nsl2vl -verisim2 $< -target $(basename $<)
#	iverilog $(addsuffix .v, $(basename $^)) -o $@.vcd
#	./$@.vcd

clean:
	rm -rf *.v *.vcd
