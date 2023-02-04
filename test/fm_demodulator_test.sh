#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a ../src/sine_lut_12_x_8.vhd
ghdl -a ../src/fm_demodulator.vhd
ghdl -a ../src/fm_demodulator_tb.vhd 
ghdl -e fm_demod_tb
echo "start sim"
ghdl -r fm_demod_tb --stop-time=20us --wave=fm_demod.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
