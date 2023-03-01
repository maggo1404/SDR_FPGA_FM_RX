library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package FM_demod_pkg is
  component FM_demod
    port(
        i_clk: in std_logic;
        i_reset: in std_logic;
        i_i: in std_logic_vector(7 downto 0);
        i_q: in std_logic_vector(7 downto 0);
        o_audio: out std_logic_vector(7 downto 0)
      );

  end component;
end FM_demod_pkg;

package body FM_demod_pkg is
end FM_demod_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FM_demod is
    port (
        i_clk: in std_logic;
        i_reset: in std_logic;
        i_i: in std_logic_vector(7 downto 0);
        i_q: in std_logic_vector(7 downto 0);
        o_audio: out std_logic_vector(7 downto 0)
    );
end entity FM_demod;

architecture rtl of FM_demod is
    -- Define constants
    constant c_size: integer := 1024;
    constant c_amplitude: integer := 32767;
    constant c_phase_factor: integer := c_size * 65536 / 62831;
    constant c_deviation: integer := 2500;
    constant c_sample_rate: integer := 24000;
    constant c_demod_factor: integer := 2 * c_deviation * c_size / c_sample_rate;

    -- Define signals
    signal s_index: integer range 0 to c_size-1 := 0;
    signal s_sin_lut: integer range -32768 to 32767 := 0;
    signal s_cos_lut: integer range -32768 to 32767 := 0;
    signal s_phase: integer range 0 to 62831 := 0;
    signal s_prev_i: integer range -128 to 127 := 0;
    signal s_prev_q: integer range -128 to 127 := 0;
    signal s_deviation: integer range -32768 to 32767 := 0;
    signal s_audio: integer range -32768 to 32767 := 0;
    signal s_audio_unsigned: integer range 0 to 65536 := 0;
    signal s_audio_std: std_logic_vector(15 downto 0);


    -- Define LUT
    type t_lut is array (0 to c_size-1) of integer range -32768 to 32767;
    constant sin_lut: t_lut := (
    0,   201,   402,   603,   804,  1005,  1206,  1406,  1607,  1808,  2009,  2209,  2410,  2610,  2811,  3011, 
 3211,  3411,  3611,  3811,  4011,  4210,  4409,  4608,  4807,  5006,  5205,  5403,  5601,  5799,  5997,  6195, 
 6392,  6589,  6786,  6982,  7179,  7375,  7571,  7766,  7961,  8156,  8351,  8545,  8739,  8932,  9126,  9319, 
 9511,  9703,  9895, 10087, 10278, 10469, 10659, 10849, 11038, 11227, 11416, 11604, 11792, 11980, 12166, 12353, 
12539, 12724, 12909, 13094, 13278, 13462, 13645, 13827, 14009, 14191, 14372, 14552, 14732, 14911, 15090, 15268, 
15446, 15623, 15799, 15975, 16150, 16325, 16499, 16672, 16845, 17017, 17189, 17360, 17530, 17699, 17868, 18036, 
18204, 18371, 18537, 18702, 18867, 19031, 19194, 19357, 19519, 19680, 19840, 20000, 20159, 20317, 20474, 20631, 
20787, 20942, 21096, 21249, 21402, 21554, 21705, 21855, 22004, 22153, 22301, 22448, 22594, 22739, 22883, 23027, 
23169, 23311, 23452, 23592, 23731, 23869, 24006, 24143, 24278, 24413, 24546, 24679, 24811, 24942, 25072, 25201, 
25329, 25456, 25582, 25707, 25831, 25954, 26077, 26198, 26318, 26437, 26556, 26673, 26789, 26905, 27019, 27132, 
27244, 27355, 27466, 27575, 27683, 27790, 27896, 28001, 28105, 28208, 28309, 28410, 28510, 28608, 28706, 28802, 
28897, 28992, 29085, 29177, 29268, 29358, 29446, 29534, 29621, 29706, 29790, 29873, 29955, 30036, 30116, 30195, 
30272, 30349, 30424, 30498, 30571, 30643, 30713, 30783, 30851, 30918, 30984, 31049, 31113, 31175, 31236, 31297, 
31356, 31413, 31470, 31525, 31580, 31633, 31684, 31735, 31785, 31833, 31880, 31926, 31970, 32014, 32056, 32097, 
32137, 32176, 32213, 32249, 32284, 32318, 32350, 32382, 32412, 32441, 32468, 32495, 32520, 32544, 32567, 32588, 
32609, 32628, 32646, 32662, 32678, 32692, 32705, 32717, 32727, 32736, 32744, 32751, 32757, 32761, 32764, 32766, 
32767, 32766, 32764, 32761, 32757, 32751, 32744, 32736, 32727, 32717, 32705, 32692, 32678, 32662, 32646, 32628, 
32609, 32588, 32567, 32544, 32520, 32495, 32468, 32441, 32412, 32382, 32350, 32318, 32284, 32249, 32213, 32176, 
32137, 32097, 32056, 32014, 31970, 31926, 31880, 31833, 31785, 31735, 31684, 31633, 31580, 31525, 31470, 31413, 
31356, 31297, 31236, 31175, 31113, 31049, 30984, 30918, 30851, 30783, 30713, 30643, 30571, 30498, 30424, 30349, 
30272, 30195, 30116, 30036, 29955, 29873, 29790, 29706, 29621, 29534, 29446, 29358, 29268, 29177, 29085, 28992, 
28897, 28802, 28706, 28608, 28510, 28410, 28309, 28208, 28105, 28001, 27896, 27790, 27683, 27575, 27466, 27355, 
27244, 27132, 27019, 26905, 26789, 26673, 26556, 26437, 26318, 26198, 26077, 25954, 25831, 25707, 25582, 25456, 
25329, 25201, 25072, 24942, 24811, 24679, 24546, 24413, 24278, 24143, 24006, 23869, 23731, 23592, 23452, 23311, 
23169, 23027, 22883, 22739, 22594, 22448, 22301, 22153, 22004, 21855, 21705, 21554, 21402, 21249, 21096, 20942, 
20787, 20631, 20474, 20317, 20159, 20000, 19840, 19680, 19519, 19357, 19194, 19031, 18867, 18702, 18537, 18371, 
18204, 18036, 17868, 17699, 17530, 17360, 17189, 17017, 16845, 16672, 16499, 16325, 16150, 15975, 15799, 15623, 
15446, 15268, 15090, 14911, 14732, 14552, 14372, 14191, 14009, 13827, 13645, 13462, 13278, 13094, 12909, 12724, 
12539, 12353, 12166, 11980, 11792, 11604, 11416, 11227, 11038, 10849, 10659, 10469, 10278, 10087,  9895,  9703, 
 9511,  9319,  9126,  8932,  8739,  8545,  8351,  8156,  7961,  7766,  7571,  7375,  7179,  6982,  6786,  6589, 
 6392,  6195,  5997,  5799,  5601,  5403,  5205,  5006,  4807,  4608,  4409,  4210,  4011,  3811,  3611,  3411, 
 3211,  3011,  2811,  2610,  2410,  2209,  2009,  1808,  1607,  1406,  1206,  1005,   804,   603,   402,   201, 
    0,  -201,  -402,  -603,  -804, -1005, -1206, -1406, -1607, -1808, -2009, -2209, -2410, -2610, -2811, -3011, 
-3211, -3411, -3611, -3811, -4011, -4210, -4409, -4608, -4807, -5006, -5205, -5403, -5601, -5799, -5997, -6195, 
-6392, -6589, -6786, -6982, -7179, -7375, -7571, -7766, -7961, -8156, -8351, -8545, -8739, -8932, -9126, -9319, 
-9511, -9703, -9895, -10087, -10278, -10469, -10659, -10849, -11038, -11227, -11416, -11604, -11792, -11980, -12166, -12353, 
-12539, -12724, -12909, -13094, -13278, -13462, -13645, -13827, -14009, -14191, -14372, -14552, -14732, -14911, -15090, -15268, 
-15446, -15623, -15799, -15975, -16150, -16325, -16499, -16672, -16845, -17017, -17189, -17360, -17530, -17699, -17868, -18036, 
-18204, -18371, -18537, -18702, -18867, -19031, -19194, -19357, -19519, -19680, -19840, -20000, -20159, -20317, -20474, -20631, 
-20787, -20942, -21096, -21249, -21402, -21554, -21705, -21855, -22004, -22153, -22301, -22448, -22594, -22739, -22883, -23027, 
-23169, -23311, -23452, -23592, -23731, -23869, -24006, -24143, -24278, -24413, -24546, -24679, -24811, -24942, -25072, -25201, 
-25329, -25456, -25582, -25707, -25831, -25954, -26077, -26198, -26318, -26437, -26556, -26673, -26789, -26905, -27019, -27132, 
-27244, -27355, -27466, -27575, -27683, -27790, -27896, -28001, -28105, -28208, -28309, -28410, -28510, -28608, -28706, -28802, 
-28897, -28992, -29085, -29177, -29268, -29358, -29446, -29534, -29621, -29706, -29790, -29873, -29955, -30036, -30116, -30195, 
-30272, -30349, -30424, -30498, -30571, -30643, -30713, -30783, -30851, -30918, -30984, -31049, -31113, -31175, -31236, -31297, 
-31356, -31413, -31470, -31525, -31580, -31633, -31684, -31735, -31785, -31833, -31880, -31926, -31970, -32014, -32056, -32097, 
-32137, -32176, -32213, -32249, -32284, -32318, -32350, -32382, -32412, -32441, -32468, -32495, -32520, -32544, -32567, -32588, 
-32609, -32628, -32646, -32662, -32678, -32692, -32705, -32717, -32727, -32736, -32744, -32751, -32757, -32761, -32764, -32766, 
-32767, -32766, -32764, -32761, -32757, -32751, -32744, -32736, -32727, -32717, -32705, -32692, -32678, -32662, -32646, -32628, 
-32609, -32588, -32567, -32544, -32520, -32495, -32468, -32441, -32412, -32382, -32350, -32318, -32284, -32249, -32213, -32176, 
-32137, -32097, -32056, -32014, -31970, -31926, -31880, -31833, -31785, -31735, -31684, -31633, -31580, -31525, -31470, -31413, 
-31356, -31297, -31236, -31175, -31113, -31049, -30984, -30918, -30851, -30783, -30713, -30643, -30571, -30498, -30424, -30349, 
-30272, -30195, -30116, -30036, -29955, -29873, -29790, -29706, -29621, -29534, -29446, -29358, -29268, -29177, -29085, -28992, 
-28897, -28802, -28706, -28608, -28510, -28410, -28309, -28208, -28105, -28001, -27896, -27790, -27683, -27575, -27466, -27355, 
-27244, -27132, -27019, -26905, -26789, -26673, -26556, -26437, -26318, -26198, -26077, -25954, -25831, -25707, -25582, -25456, 
-25329, -25201, -25072, -24942, -24811, -24679, -24546, -24413, -24278, -24143, -24006, -23869, -23731, -23592, -23452, -23311, 
-23169, -23027, -22883, -22739, -22594, -22448, -22301, -22153, -22004, -21855, -21705, -21554, -21402, -21249, -21096, -20942, 
-20787, -20631, -20474, -20317, -20159, -20000, -19840, -19680, -19519, -19357, -19194, -19031, -18867, -18702, -18537, -18371, 
-18204, -18036, -17868, -17699, -17530, -17360, -17189, -17017, -16845, -16672, -16499, -16325, -16150, -15975, -15799, -15623, 
-15446, -15268, -15090, -14911, -14732, -14552, -14372, -14191, -14009, -13827, -13645, -13462, -13278, -13094, -12909, -12724, 
-12539, -12353, -12166, -11980, -11792, -11604, -11416, -11227, -11038, -10849, -10659, -10469, -10278, -10087, -9895, -9703, 
-9511, -9319, -9126, -8932, -8739, -8545, -8351, -8156, -7961, -7766, -7571, -7375, -7179, -6982, -6786, -6589, 
-6392, -6195, -5997, -5799, -5601, -5403, -5205, -5006, -4807, -4608, -4409, -4210, -4011, -3811, -3611, -3411, 
-3211, -3011, -2811, -2610, -2410, -2209, -2009, -1808, -1607, -1406, -1206, -1005,  -804,  -603,  -402,  -201 
);

    constant cos_lut: t_lut := (
32767, 32766, 32764, 32761, 32757, 32751, 32744, 32736, 32727, 32717, 32705, 32692, 32678, 32662, 32646, 32628, 
32609, 32588, 32567, 32544, 32520, 32495, 32468, 32441, 32412, 32382, 32350, 32318, 32284, 32249, 32213, 32176, 
32137, 32097, 32056, 32014, 31970, 31926, 31880, 31833, 31785, 31735, 31684, 31633, 31580, 31525, 31470, 31413, 
31356, 31297, 31236, 31175, 31113, 31049, 30984, 30918, 30851, 30783, 30713, 30643, 30571, 30498, 30424, 30349, 
30272, 30195, 30116, 30036, 29955, 29873, 29790, 29706, 29621, 29534, 29446, 29358, 29268, 29177, 29085, 28992, 
28897, 28802, 28706, 28608, 28510, 28410, 28309, 28208, 28105, 28001, 27896, 27790, 27683, 27575, 27466, 27355, 
27244, 27132, 27019, 26905, 26789, 26673, 26556, 26437, 26318, 26198, 26077, 25954, 25831, 25707, 25582, 25456, 
25329, 25201, 25072, 24942, 24811, 24679, 24546, 24413, 24278, 24143, 24006, 23869, 23731, 23592, 23452, 23311, 
23169, 23027, 22883, 22739, 22594, 22448, 22301, 22153, 22004, 21855, 21705, 21554, 21402, 21249, 21096, 20942, 
20787, 20631, 20474, 20317, 20159, 20000, 19840, 19680, 19519, 19357, 19194, 19031, 18867, 18702, 18537, 18371, 
18204, 18036, 17868, 17699, 17530, 17360, 17189, 17017, 16845, 16672, 16499, 16325, 16150, 15975, 15799, 15623, 
15446, 15268, 15090, 14911, 14732, 14552, 14372, 14191, 14009, 13827, 13645, 13462, 13278, 13094, 12909, 12724, 
12539, 12353, 12166, 11980, 11792, 11604, 11416, 11227, 11038, 10849, 10659, 10469, 10278, 10087,  9895,  9703, 
 9511,  9319,  9126,  8932,  8739,  8545,  8351,  8156,  7961,  7766,  7571,  7375,  7179,  6982,  6786,  6589, 
 6392,  6195,  5997,  5799,  5601,  5403,  5205,  5006,  4807,  4608,  4409,  4210,  4011,  3811,  3611,  3411, 
 3211,  3011,  2811,  2610,  2410,  2209,  2009,  1808,  1607,  1406,  1206,  1005,   804,   603,   402,   201, 
    0,  -201,  -402,  -603,  -804, -1005, -1206, -1406, -1607, -1808, -2009, -2209, -2410, -2610, -2811, -3011, 
-3211, -3411, -3611, -3811, -4011, -4210, -4409, -4608, -4807, -5006, -5205, -5403, -5601, -5799, -5997, -6195, 
-6392, -6589, -6786, -6982, -7179, -7375, -7571, -7766, -7961, -8156, -8351, -8545, -8739, -8932, -9126, -9319, 
-9511, -9703, -9895, -10087, -10278, -10469, -10659, -10849, -11038, -11227, -11416, -11604, -11792, -11980, -12166, -12353, 
-12539, -12724, -12909, -13094, -13278, -13462, -13645, -13827, -14009, -14191, -14372, -14552, -14732, -14911, -15090, -15268, 
-15446, -15623, -15799, -15975, -16150, -16325, -16499, -16672, -16845, -17017, -17189, -17360, -17530, -17699, -17868, -18036, 
-18204, -18371, -18537, -18702, -18867, -19031, -19194, -19357, -19519, -19680, -19840, -20000, -20159, -20317, -20474, -20631, 
-20787, -20942, -21096, -21249, -21402, -21554, -21705, -21855, -22004, -22153, -22301, -22448, -22594, -22739, -22883, -23027, 
-23169, -23311, -23452, -23592, -23731, -23869, -24006, -24143, -24278, -24413, -24546, -24679, -24811, -24942, -25072, -25201, 
-25329, -25456, -25582, -25707, -25831, -25954, -26077, -26198, -26318, -26437, -26556, -26673, -26789, -26905, -27019, -27132, 
-27244, -27355, -27466, -27575, -27683, -27790, -27896, -28001, -28105, -28208, -28309, -28410, -28510, -28608, -28706, -28802, 
-28897, -28992, -29085, -29177, -29268, -29358, -29446, -29534, -29621, -29706, -29790, -29873, -29955, -30036, -30116, -30195, 
-30272, -30349, -30424, -30498, -30571, -30643, -30713, -30783, -30851, -30918, -30984, -31049, -31113, -31175, -31236, -31297, 
-31356, -31413, -31470, -31525, -31580, -31633, -31684, -31735, -31785, -31833, -31880, -31926, -31970, -32014, -32056, -32097, 
-32137, -32176, -32213, -32249, -32284, -32318, -32350, -32382, -32412, -32441, -32468, -32495, -32520, -32544, -32567, -32588, 
-32609, -32628, -32646, -32662, -32678, -32692, -32705, -32717, -32727, -32736, -32744, -32751, -32757, -32761, -32764, -32766, 
-32767, -32766, -32764, -32761, -32757, -32751, -32744, -32736, -32727, -32717, -32705, -32692, -32678, -32662, -32646, -32628, 
-32609, -32588, -32567, -32544, -32520, -32495, -32468, -32441, -32412, -32382, -32350, -32318, -32284, -32249, -32213, -32176, 
-32137, -32097, -32056, -32014, -31970, -31926, -31880, -31833, -31785, -31735, -31684, -31633, -31580, -31525, -31470, -31413, 
-31356, -31297, -31236, -31175, -31113, -31049, -30984, -30918, -30851, -30783, -30713, -30643, -30571, -30498, -30424, -30349, 
-30272, -30195, -30116, -30036, -29955, -29873, -29790, -29706, -29621, -29534, -29446, -29358, -29268, -29177, -29085, -28992, 
-28897, -28802, -28706, -28608, -28510, -28410, -28309, -28208, -28105, -28001, -27896, -27790, -27683, -27575, -27466, -27355, 
-27244, -27132, -27019, -26905, -26789, -26673, -26556, -26437, -26318, -26198, -26077, -25954, -25831, -25707, -25582, -25456, 
-25329, -25201, -25072, -24942, -24811, -24679, -24546, -24413, -24278, -24143, -24006, -23869, -23731, -23592, -23452, -23311, 
-23169, -23027, -22883, -22739, -22594, -22448, -22301, -22153, -22004, -21855, -21705, -21554, -21402, -21249, -21096, -20942, 
-20787, -20631, -20474, -20317, -20159, -20000, -19840, -19680, -19519, -19357, -19194, -19031, -18867, -18702, -18537, -18371, 
-18204, -18036, -17868, -17699, -17530, -17360, -17189, -17017, -16845, -16672, -16499, -16325, -16150, -15975, -15799, -15623, 
-15446, -15268, -15090, -14911, -14732, -14552, -14372, -14191, -14009, -13827, -13645, -13462, -13278, -13094, -12909, -12724, 
-12539, -12353, -12166, -11980, -11792, -11604, -11416, -11227, -11038, -10849, -10659, -10469, -10278, -10087, -9895, -9703, 
-9511, -9319, -9126, -8932, -8739, -8545, -8351, -8156, -7961, -7766, -7571, -7375, -7179, -6982, -6786, -6589, 
-6392, -6195, -5997, -5799, -5601, -5403, -5205, -5006, -4807, -4608, -4409, -4210, -4011, -3811, -3611, -3411, 
-3211, -3011, -2811, -2610, -2410, -2209, -2009, -1808, -1607, -1406, -1206, -1005,  -804,  -603,  -402,  -201, 
    0,   201,   402,   603,   804,  1005,  1206,  1406,  1607,  1808,  2009,  2209,  2410,  2610,  2811,  3011, 
 3211,  3411,  3611,  3811,  4011,  4210,  4409,  4608,  4807,  5006,  5205,  5403,  5601,  5799,  5997,  6195, 
 6392,  6589,  6786,  6982,  7179,  7375,  7571,  7766,  7961,  8156,  8351,  8545,  8739,  8932,  9126,  9319, 
 9511,  9703,  9895, 10087, 10278, 10469, 10659, 10849, 11038, 11227, 11416, 11604, 11792, 11980, 12166, 12353, 
12539, 12724, 12909, 13094, 13278, 13462, 13645, 13827, 14009, 14191, 14372, 14552, 14732, 14911, 15090, 15268, 
15446, 15623, 15799, 15975, 16150, 16325, 16499, 16672, 16845, 17017, 17189, 17360, 17530, 17699, 17868, 18036, 
18204, 18371, 18537, 18702, 18867, 19031, 19194, 19357, 19519, 19680, 19840, 20000, 20159, 20317, 20474, 20631, 
20787, 20942, 21096, 21249, 21402, 21554, 21705, 21855, 22004, 22153, 22301, 22448, 22594, 22739, 22883, 23027, 
23169, 23311, 23452, 23592, 23731, 23869, 24006, 24143, 24278, 24413, 24546, 24679, 24811, 24942, 25072, 25201, 
25329, 25456, 25582, 25707, 25831, 25954, 26077, 26198, 26318, 26437, 26556, 26673, 26789, 26905, 27019, 27132, 
27244, 27355, 27466, 27575, 27683, 27790, 27896, 28001, 28105, 28208, 28309, 28410, 28510, 28608, 28706, 28802, 
28897, 28992, 29085, 29177, 29268, 29358, 29446, 29534, 29621, 29706, 29790, 29873, 29955, 30036, 30116, 30195, 
30272, 30349, 30424, 30498, 30571, 30643, 30713, 30783, 30851, 30918, 30984, 31049, 31113, 31175, 31236, 31297, 
31356, 31413, 31470, 31525, 31580, 31633, 31684, 31735, 31785, 31833, 31880, 31926, 31970, 32014, 32056, 32097, 
32137, 32176, 32213, 32249, 32284, 32318, 32350, 32382, 32412, 32441, 32468, 32495, 32520, 32544, 32567, 32588, 
32609, 32628, 32646, 32662, 32678, 32692, 32705, 32717, 32727, 32736, 32744, 32751, 32757, 32761, 32764, 32766 
);


begin
        process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                s_prev_i <= 0;
                s_prev_q <= 0;
                s_deviation <= 0;
                s_audio <= 0;
            else
                -- Calculate deviation from previous sample
                s_deviation <= s_prev_i * to_integer(signed(i_q)) - s_prev_q * to_integer(signed(i_i));
                s_prev_i <= to_integer(signed(i_i));
                s_prev_q <= to_integer(signed(i_q));

                -- Calculate phase from deviation
                s_phase <= s_phase + s_deviation * c_demod_factor;

                -- Calculate sin(x) and cos(x) outputs based on input phase
                s_index <= integer(s_phase * c_phase_factor / 65536);
                s_sin_lut <= sin_lut(s_index);
                s_cos_lut <= cos_lut(s_index);

                -- Calculate audio output
                s_audio <= to_integer(signed(i_i)) * s_cos_lut - to_integer(signed(i_q)) * s_sin_lut;

                -- Output audio sample
                s_audio_unsigned <= s_audio + 32767;
                s_audio_std <= std_logic_vector(to_unsigned(s_audio_unsigned, s_audio_std'length));
                o_audio <= s_audio_std(15 downto 8);
            end if;
        end if;
    end process;

end architecture rtl;
