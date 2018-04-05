#!/bin/bash

set -xeu

nsl2vl -verisim2 test_tb.nsl -target test_tb
iverilog test_tb.v
./a.out
gtkwave test_tb.vcd
