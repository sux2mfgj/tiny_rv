
decode.nsl: decode.nh
decode: decode.v


.SUFFIXES: .nsl .v
.nsl.v:
	nsl2vl $<


decode: decode.v decode_tb.nsl execute_dumy.v
	nsl2vl -verisim2 decode_tb.nsl -target decode_tb
	iverilog decode.v decode_tb.v execute_dumy.v
