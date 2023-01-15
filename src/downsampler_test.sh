#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a downsampler.vhd
ghdl -a downsampler_tb.vhd 
ghdl -e downsampler_tb 
echo "start sim"
ghdl -r downsampler_tb --stop-time=20us --wave=downsampler_tb.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
