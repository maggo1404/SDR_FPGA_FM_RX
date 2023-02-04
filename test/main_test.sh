#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a ../src/dds_synthesizer.vhd
ghdl -a ../src/downsampler.vhd
ghdl -a ../src/firfilter.vhd
ghdl -a ../src/fm_demodulator.vhd
ghdl -a ../src/main.vhd
ghdl -a ../src/main_tb.vhd 
ghdl -e tb_SDR_Main  
echo "start sim"
ghdl -r tb_SDR_Main  --stop-time=20us --wave=mixer_tb.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
