//Copyright (C)2014-2022 GOWIN Semiconductor Corporation.
//All rights reserved.
//File Title: Timing Constraints file
//GOWIN Version: 1.9.8.09 Education
//Created Time: 2022-12-25 11:00:29
create_clock -name Systemclock -period 37.037 -waveform {0 18.518} [get_ports {clk_main}]
