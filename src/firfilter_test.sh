#!/bin/bash
begin=$(date +%s)
# echo "Start bei $begin"
ghdl -a firfilter.vhd
ghdl -a firfilter_tb.vhd 
ghdl -e firfilter_tb 
echo "start sim"
ghdl -r firfilter_tb --stop-time=20us --wave=firfilter_tb.ghw
ende=$(date +%s)
temp=$(( $ende - $begin ))
echo "Laufzeit $temp"
