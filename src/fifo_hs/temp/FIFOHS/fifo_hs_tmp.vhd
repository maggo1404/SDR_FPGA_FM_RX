--Copyright (C)2014-2022 Gowin Semiconductor Corporation.
--All rights reserved.
--File Title: Template file for instantiation
--GOWIN Version: GowinSynthesis V1.9.8.09 Education
--Part Number: GW1NR-LV9QN88PC6/I5
--Device: GW1NR-9C
--Created Time: Wed Mar 01 19:18:13 2023

--Change the instance name and port connections to the signal names
----------Copy here to design--------

component FIFO_HS_Top
	port (
		Data: in std_logic_vector(15 downto 0);
		WrClk: in std_logic;
		RdClk: in std_logic;
		WrEn: in std_logic;
		RdEn: in std_logic;
		Q: out std_logic_vector(7 downto 0);
		Empty: out std_logic;
		Full: out std_logic
	);
end component;

your_instance_name: FIFO_HS_Top
	port map (
		Data => Data_i,
		WrClk => WrClk_i,
		RdClk => RdClk_i,
		WrEn => WrEn_i,
		RdEn => RdEn_i,
		Q => Q_o,
		Empty => Empty_o,
		Full => Full_o
	);

----------Copy end-------------------
