//Copyright (C)2014-2023 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8.09 Education
//Created Time: 2023-03-01 14:30:11
create_clock -name Systemclock -period 37.037 -waveform {0 18.518} [get_ports {clk_main}]
create_clock -name uart_rx -period 8695.652 -waveform {0 4347.826} [get_ports {uart_in_pin}]
