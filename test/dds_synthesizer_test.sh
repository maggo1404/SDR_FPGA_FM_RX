#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a --ieee=synopsys ../src/sine_lut_12_x_8.vhd
ghdl -a --ieee=synopsys ../src/dds_synthesizer.vhd
ghdl -a --ieee=synopsys ../src/dds_synthesizer_tb.vhd 
ghdl -e dds_synthesizer_tb
echo "start sim"
ghdl -r dds_synthesizer_tb --stop-time=20us --wave=fm_demod.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
