#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a ../src/mixer.vhd
ghdl -a ../src/mixer_tb.vhd 
ghdl -e tb_mixer_osc 
echo "start sim"
ghdl -r tb_mixer_osc --stop-time=20us --wave=mixer_tb.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
