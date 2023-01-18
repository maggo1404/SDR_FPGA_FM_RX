#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a ../src/downsampler.vhd
ghdl -a ../src/downsampler_tb.vhd 
ghdl -e downsampler_tb 
echo "start sim"
ghdl -r downsampler_tb --stop-time=20us --wave=downsampler_tb.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
