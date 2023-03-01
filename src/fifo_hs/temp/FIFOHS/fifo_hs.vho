--
--Written by GowinSynthesis
--Product Version "GowinSynthesis V1.9.8.09 Education"
--Wed Mar 01 19:18:13 2023

--Source file index table:
--file0 "\C:/Gowin/Gowin_V1.9.8.09_Education/IDE/ipcore/FIFO_HS/data/fifo_hs.v"
--file1 "\C:/Gowin/Gowin_V1.9.8.09_Education/IDE/ipcore/FIFO_HS/data/fifo_hs_top.v"
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library gw1n;
use gw1n.components.all;

entity FIFO_HS_Top is
port(
  Data :  in std_logic_vector(15 downto 0);
  WrClk :  in std_logic;
  RdClk :  in std_logic;
  WrEn :  in std_logic;
  RdEn :  in std_logic;
  Q :  out std_logic_vector(7 downto 0);
  Empty :  out std_logic;
  Full :  out std_logic);
end FIFO_HS_Top;
architecture beh of FIFO_HS_Top is
  signal fifo_inst_rempty_val1 : std_logic ;
  signal fifo_inst_wfull_val1 : std_logic ;
  signal fifo_inst_n31 : std_logic ;
  signal fifo_inst_n32 : std_logic ;
  signal fifo_inst_n33 : std_logic ;
  signal fifo_inst_n34 : std_logic ;
  signal fifo_inst_n27 : std_logic ;
  signal fifo_inst_n28 : std_logic ;
  signal fifo_inst_n29 : std_logic ;
  signal fifo_inst_n30 : std_logic ;
  signal fifo_inst_n23 : std_logic ;
  signal fifo_inst_n24 : std_logic ;
  signal fifo_inst_n25 : std_logic ;
  signal fifo_inst_n26 : std_logic ;
  signal fifo_inst_n19 : std_logic ;
  signal fifo_inst_n20 : std_logic ;
  signal fifo_inst_n21 : std_logic ;
  signal fifo_inst_n22 : std_logic ;
  signal fifo_inst_n156 : std_logic ;
  signal fifo_inst_n156_3 : std_logic ;
  signal fifo_inst_n157 : std_logic ;
  signal fifo_inst_n157_3 : std_logic ;
  signal fifo_inst_n14 : std_logic ;
  signal fifo_inst_n18 : std_logic ;
  signal fifo_inst_wfull_val : std_logic ;
  signal \fifo_inst_Small.rgraynext_1\ : std_logic ;
  signal fifo_inst_wfull_val_4 : std_logic ;
  signal \fifo_inst_Small.wbinnext_0\ : std_logic ;
  signal fifo_inst_rbin_num_next_0 : std_logic ;
  signal fifo_inst_rempty_val : std_logic ;
  signal GND_0 : std_logic ;
  signal VCC_0 : std_logic ;
  signal \fifo_inst/rbin_num\ : std_logic_vector(2 downto 0);
  signal \fifo_inst/Small.wdata\ : std_logic_vector(15 downto 0);
  signal \fifo_inst/Small.rptr\ : std_logic_vector(2 downto 0);
  signal \fifo_inst/Small.wptr\ : std_logic_vector(2 downto 0);
  signal \fifo_inst/Small.wbin\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/Small.rgraynext\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/Small.wgraynext\ : std_logic_vector(1 downto 0);
  signal \fifo_inst/rbin_num_next\ : std_logic_vector(3 downto 1);
  signal \fifo_inst/Small.wbinnext\ : std_logic_vector(2 downto 1);
  signal NN : std_logic;
  signal NN_0 : std_logic;
begin
\fifo_inst/rbin_num_2_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(2),
  D => \fifo_inst/rbin_num_next\(2),
  CLK => RdClk);
\fifo_inst/rbin_num_1_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(1),
  D => \fifo_inst/rbin_num_next\(1),
  CLK => RdClk);
\fifo_inst/rbin_num_0_s0\: DFF
port map (
  Q => \fifo_inst/rbin_num\(0),
  D => fifo_inst_rbin_num_next_0,
  CLK => RdClk);
\fifo_inst/Small.wdata_15_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(15),
  D => fifo_inst_n19,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_14_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(14),
  D => fifo_inst_n20,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_13_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(13),
  D => fifo_inst_n21,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_12_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(12),
  D => fifo_inst_n22,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_11_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(11),
  D => fifo_inst_n23,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_10_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(10),
  D => fifo_inst_n24,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_9_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(9),
  D => fifo_inst_n25,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_8_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(8),
  D => fifo_inst_n26,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_7_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(7),
  D => fifo_inst_n27,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_6_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(6),
  D => fifo_inst_n28,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_5_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(5),
  D => fifo_inst_n29,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_4_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(4),
  D => fifo_inst_n30,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_3_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(3),
  D => fifo_inst_n31,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_2_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(2),
  D => fifo_inst_n32,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_1_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(1),
  D => fifo_inst_n33,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.wdata_0_s0\: DFFE
port map (
  Q => \fifo_inst/Small.wdata\(0),
  D => fifo_inst_n34,
  CLK => RdClk,
  CE => fifo_inst_n18);
\fifo_inst/Small.rptr_2_s0\: DFF
port map (
  Q => \fifo_inst/Small.rptr\(2),
  D => \fifo_inst/rbin_num_next\(3),
  CLK => RdClk);
\fifo_inst/Small.rptr_1_s0\: DFF
port map (
  Q => \fifo_inst/Small.rptr\(1),
  D => \fifo_inst/Small.rgraynext\(1),
  CLK => RdClk);
\fifo_inst/Small.rptr_0_s0\: DFF
port map (
  Q => \fifo_inst/Small.rptr\(0),
  D => \fifo_inst/Small.rgraynext\(0),
  CLK => RdClk);
\fifo_inst/Small.wptr_2_s0\: DFF
port map (
  Q => \fifo_inst/Small.wptr\(2),
  D => \fifo_inst/Small.wbinnext\(2),
  CLK => WrClk);
\fifo_inst/Small.wptr_1_s0\: DFF
port map (
  Q => \fifo_inst/Small.wptr\(1),
  D => \fifo_inst/Small.wgraynext\(1),
  CLK => WrClk);
\fifo_inst/Small.wptr_0_s0\: DFF
port map (
  Q => \fifo_inst/Small.wptr\(0),
  D => \fifo_inst/Small.wgraynext\(0),
  CLK => WrClk);
\fifo_inst/Small.wbin_1_s0\: DFF
port map (
  Q => \fifo_inst/Small.wbin\(1),
  D => \fifo_inst/Small.wbinnext\(1),
  CLK => WrClk);
\fifo_inst/Small.wbin_0_s0\: DFF
port map (
  Q => \fifo_inst/Small.wbin\(0),
  D => \fifo_inst_Small.wbinnext_0\,
  CLK => WrClk);
\fifo_inst/rempty_val1_s0\: DFFP
port map (
  Q => fifo_inst_rempty_val1,
  D => fifo_inst_rempty_val,
  CLK => RdClk,
  PRESET => fifo_inst_rempty_val);
\fifo_inst/Empty_s0\: DFFP
port map (
  Q => NN,
  D => fifo_inst_rempty_val1,
  CLK => RdClk,
  PRESET => fifo_inst_rempty_val);
\fifo_inst/wfull_val1_s0\: DFFP
port map (
  Q => fifo_inst_wfull_val1,
  D => fifo_inst_wfull_val,
  CLK => WrClk,
  PRESET => fifo_inst_wfull_val);
\fifo_inst/Full_s0\: DFFP
port map (
  Q => NN_0,
  D => fifo_inst_wfull_val1,
  CLK => WrClk,
  PRESET => fifo_inst_wfull_val);
\fifo_inst/Small.mem_Small.mem_0_0_s\: RAM16SDP4
port map (
  DO(3) => fifo_inst_n31,
  DO(2) => fifo_inst_n32,
  DO(1) => fifo_inst_n33,
  DO(0) => fifo_inst_n34,
  DI(3 downto 0) => Data(3 downto 0),
  WAD(3) => GND_0,
  WAD(2) => GND_0,
  WAD(1 downto 0) => \fifo_inst/Small.wbin\(1 downto 0),
  RAD(3) => GND_0,
  RAD(2) => GND_0,
  RAD(1 downto 0) => \fifo_inst/rbin_num\(2 downto 1),
  WRE => fifo_inst_n14,
  CLK => WrClk);
\fifo_inst/Small.mem_Small.mem_0_1_s\: RAM16SDP4
port map (
  DO(3) => fifo_inst_n27,
  DO(2) => fifo_inst_n28,
  DO(1) => fifo_inst_n29,
  DO(0) => fifo_inst_n30,
  DI(3 downto 0) => Data(7 downto 4),
  WAD(3) => GND_0,
  WAD(2) => GND_0,
  WAD(1 downto 0) => \fifo_inst/Small.wbin\(1 downto 0),
  RAD(3) => GND_0,
  RAD(2) => GND_0,
  RAD(1 downto 0) => \fifo_inst/rbin_num\(2 downto 1),
  WRE => fifo_inst_n14,
  CLK => WrClk);
\fifo_inst/Small.mem_Small.mem_0_2_s\: RAM16SDP4
port map (
  DO(3) => fifo_inst_n23,
  DO(2) => fifo_inst_n24,
  DO(1) => fifo_inst_n25,
  DO(0) => fifo_inst_n26,
  DI(3 downto 0) => Data(11 downto 8),
  WAD(3) => GND_0,
  WAD(2) => GND_0,
  WAD(1 downto 0) => \fifo_inst/Small.wbin\(1 downto 0),
  RAD(3) => GND_0,
  RAD(2) => GND_0,
  RAD(1 downto 0) => \fifo_inst/rbin_num\(2 downto 1),
  WRE => fifo_inst_n14,
  CLK => WrClk);
\fifo_inst/Small.mem_Small.mem_0_3_s\: RAM16SDP4
port map (
  DO(3) => fifo_inst_n19,
  DO(2) => fifo_inst_n20,
  DO(1) => fifo_inst_n21,
  DO(0) => fifo_inst_n22,
  DI(3 downto 0) => Data(15 downto 12),
  WAD(3) => GND_0,
  WAD(2) => GND_0,
  WAD(1 downto 0) => \fifo_inst/Small.wbin\(1 downto 0),
  RAD(3) => GND_0,
  RAD(2) => GND_0,
  RAD(1 downto 0) => \fifo_inst/rbin_num\(2 downto 1),
  WRE => fifo_inst_n14,
  CLK => WrClk);
\fifo_inst/n156_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n156,
  COUT => fifo_inst_n156_3,
  I0 => \fifo_inst/Small.wptr\(0),
  I1 => \fifo_inst/Small.rptr\(0),
  I3 => GND_0,
  CIN => GND_0);
\fifo_inst/n157_s0\: ALU
generic map (
  ALU_MODE => 3
)
port map (
  SUM => fifo_inst_n157,
  COUT => fifo_inst_n157_3,
  I0 => \fifo_inst/Small.wptr\(1),
  I1 => \fifo_inst/Small.rptr\(1),
  I3 => GND_0,
  CIN => fifo_inst_n156_3);
\fifo_inst/n14_s0\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n14,
  I0 => NN_0,
  I1 => WrEn);
\fifo_inst/n18_s0\: LUT2
generic map (
  INIT => X"4"
)
port map (
  F => fifo_inst_n18,
  I0 => NN,
  I1 => RdEn);
\fifo_inst/Q_d_7_s\: LUT3
generic map (
  INIT => X"AC"
)
port map (
  F => Q(7),
  I0 => \fifo_inst/Small.wdata\(7),
  I1 => \fifo_inst/Small.wdata\(15),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_6_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(6),
  I0 => \fifo_inst/Small.wdata\(14),
  I1 => \fifo_inst/Small.wdata\(6),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_5_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(5),
  I0 => \fifo_inst/Small.wdata\(13),
  I1 => \fifo_inst/Small.wdata\(5),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_4_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(4),
  I0 => \fifo_inst/Small.wdata\(12),
  I1 => \fifo_inst/Small.wdata\(4),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_3_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(3),
  I0 => \fifo_inst/Small.wdata\(11),
  I1 => \fifo_inst/Small.wdata\(3),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_2_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(2),
  I0 => \fifo_inst/Small.wdata\(10),
  I1 => \fifo_inst/Small.wdata\(2),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_1_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(1),
  I0 => \fifo_inst/Small.wdata\(9),
  I1 => \fifo_inst/Small.wdata\(1),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Q_d_0_s\: LUT3
generic map (
  INIT => X"CA"
)
port map (
  F => Q(0),
  I0 => \fifo_inst/Small.wdata\(8),
  I1 => \fifo_inst/Small.wdata\(0),
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/Small.rgraynext_0_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.rgraynext\(0),
  I0 => fifo_inst_n18,
  I1 => \fifo_inst/rbin_num\(0),
  I2 => \fifo_inst/rbin_num\(1),
  I3 => \fifo_inst/rbin_num\(2));
\fifo_inst/Small.rgraynext_1_s0\: LUT3
generic map (
  INIT => X"1E"
)
port map (
  F => \fifo_inst/Small.rgraynext\(1),
  I0 => \fifo_inst_Small.rgraynext_1\,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/Small.rptr\(2));
\fifo_inst/Small.wgraynext_1_s0\: LUT4
generic map (
  INIT => X"07F8"
)
port map (
  F => \fifo_inst/Small.wgraynext\(1),
  I0 => fifo_inst_n14,
  I1 => \fifo_inst/Small.wbin\(0),
  I2 => \fifo_inst/Small.wbin\(1),
  I3 => \fifo_inst/Small.wptr\(2));
\fifo_inst/wfull_val_s0\: LUT3
generic map (
  INIT => X"60"
)
port map (
  F => fifo_inst_wfull_val,
  I0 => \fifo_inst/Small.wptr\(2),
  I1 => \fifo_inst/Small.rptr\(2),
  I2 => fifo_inst_wfull_val_4);
\fifo_inst/rbin_num_next_2_s3\: LUT2
generic map (
  INIT => X"6"
)
port map (
  F => \fifo_inst/rbin_num_next\(2),
  I0 => \fifo_inst_Small.rgraynext_1\,
  I1 => \fifo_inst/rbin_num\(2));
\fifo_inst/rbin_num_next_3_s2\: LUT3
generic map (
  INIT => X"78"
)
port map (
  F => \fifo_inst/rbin_num_next\(3),
  I0 => \fifo_inst_Small.rgraynext_1\,
  I1 => \fifo_inst/rbin_num\(2),
  I2 => \fifo_inst/Small.rptr\(2));
\fifo_inst/Small.wbinnext_2_s2\: LUT4
generic map (
  INIT => X"7F80"
)
port map (
  F => \fifo_inst/Small.wbinnext\(2),
  I0 => fifo_inst_n14,
  I1 => \fifo_inst/Small.wbin\(0),
  I2 => \fifo_inst/Small.wbin\(1),
  I3 => \fifo_inst/Small.wptr\(2));
\fifo_inst/Small.rgraynext_1_s1\: LUT4
generic map (
  INIT => X"4000"
)
port map (
  F => \fifo_inst_Small.rgraynext_1\,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/wfull_val_s1\: LUT4
generic map (
  INIT => X"0990"
)
port map (
  F => fifo_inst_wfull_val_4,
  I0 => \fifo_inst/Small.wptr\(0),
  I1 => \fifo_inst/Small.rptr\(0),
  I2 => \fifo_inst/Small.wptr\(1),
  I3 => \fifo_inst/Small.rptr\(1));
\fifo_inst/Small.wbinnext_1_s4\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/Small.wbinnext\(1),
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Small.wbin\(0),
  I3 => \fifo_inst/Small.wbin\(1));
\fifo_inst/Small.wbinnext_0_s4\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => \fifo_inst_Small.wbinnext_0\,
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Small.wbin\(0));
\fifo_inst/Small.wgraynext_0_s1\: LUT4
generic map (
  INIT => X"0BF4"
)
port map (
  F => \fifo_inst/Small.wgraynext\(0),
  I0 => NN_0,
  I1 => WrEn,
  I2 => \fifo_inst/Small.wbin\(0),
  I3 => \fifo_inst/Small.wbin\(1));
\fifo_inst/rbin_num_next_1_s4\: LUT4
generic map (
  INIT => X"BF40"
)
port map (
  F => \fifo_inst/rbin_num_next\(1),
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0),
  I3 => \fifo_inst/rbin_num\(1));
\fifo_inst/rbin_num_next_0_s4\: LUT3
generic map (
  INIT => X"B4"
)
port map (
  F => fifo_inst_rbin_num_next_0,
  I0 => NN,
  I1 => RdEn,
  I2 => \fifo_inst/rbin_num\(0));
\fifo_inst/rempty_val_s2\: LUT3
generic map (
  INIT => X"09"
)
port map (
  F => fifo_inst_rempty_val,
  I0 => \fifo_inst/Small.wptr\(2),
  I1 => \fifo_inst/Small.rptr\(2),
  I2 => fifo_inst_n157_3);
GND_s0: GND
port map (
  G => GND_0);
VCC_s0: VCC
port map (
  V => VCC_0);
GSR_0: GSR
port map (
  GSRI => VCC_0);
  Empty <= NN;
  Full <= NN_0;
end beh;
