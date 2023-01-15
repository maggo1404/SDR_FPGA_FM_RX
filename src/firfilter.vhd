library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_arith.all;
--use IEEE.STD_LOGIC_unsigned.all;

-- queele http://t-filter.engineerjs.com/

package FIR_filter_pkg is
  component FIR_filter
    port(
        clock : in std_logic;
        reset : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
        );
  end component;
end FIR_filter_pkg;

package body FIR_filter_pkg is
end FIR_filter_pkg;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_arith.all;
--use IEEE.STD_LOGIC_unsigned.all;

entity FIR_filter is
    port(
        clock : in std_logic;
        reset : in std_logic;
        data_in : in std_logic_vector(15 downto 0);
        data_out : out std_logic_vector(15 downto 0)
    );
end FIR_filter;

architecture FIR_filter_arch of FIR_filter is

    type coef_array is array(0 to 276) of signed(15 downto 0);
--    constant coefficients : coef_array := (  -173, -24, -25, -27, -28, -30, -32, -33, -35, -37, -38, -40, -42, -44, -45, -47, -48, -50, -52, -53, -55, -56, -58, -59, -60, -61, -63, -64, -65, -65, -66, -67, -67, -68, -68, -68, -68, -68, -68, -68, -67, -66, -65, -64, -63, -62, -60, -58, -56, -54, -52, -49, -46, -43, -40, -36, -33, -29, -25, -20, -16, -11, -6, -1, 5, 10, 16, 22, 29, 35, 42, 49, 56, 64, 71, 79, 87, 95, 103, 111, 120, 128, 137, 146, 155, 164, 174, 183, 192, 202, 211, 221, 230, 240, 250, 259, 269, 279, 288, 298, 307, 317, 326, 336, 345, 354, 363, 372, 380, 389, 397, 405, 413, 421, 429, 436, 443, 450, 456, 463, 469, 475, 480, 485, 490, 495, 499, 503, 507, 510, 513, 516, 518, 520, 522, 523, 524, 524, 524, 524, 524, 523, 522, 520, 518, 516, 513, 510, 507, 503, 499, 495, 490, 485, 480, 475, 469, 463, 456, 450, 443, 436, 429, 421, 413, 405, 397, 389, 380, 372, 363, 354, 345, 336, 326, 317, 307, 298, 288, 279, 269, 259, 250, 240, 230, 221, 211, 202, 192, 183, 174, 164, 155, 146, 137, 128, 120, 111, 103, 95, 87, 79, 71, 64, 56, 49, 42, 35, 29, 22, 16, 10, 5, -1, -6, -11, -16, -20, -25, -29, -33, -36, -40, -43, -46, -49, -52, -54, -56, -58, -60, -62, -63, -64, -65, -66, -67, -68, -68, -68, -68, -68, -68, -68, -67, -67, -66, -65, -65, -64, -63, -61, -60, -59, -58, -56, -55, -53, -52, -50, -48, -47, -45, -44, -42, -40, -38, -37, -35, -33, -32, -30, -28, -27, -25, -24, -173);
    constant coefficients : coef_array := ( to_signed(-173,16),to_signed( -24,16),to_signed( -25,16),to_signed( -27,16),to_signed( -28,16),to_signed( -30,16),to_signed( -32,16),to_signed( -33,16),to_signed( -35,16),to_signed( -37,16),to_signed( -38,16),to_signed( -40,16),to_signed( -42,16),to_signed( -44,16),to_signed( -45,16),to_signed( -47,16),to_signed( -48,16),to_signed( -50,16),to_signed( -52,16),to_signed( -53,16),to_signed( -55,16),to_signed( -56,16),to_signed( -58,16),to_signed( -59,16),to_signed( -60,16),to_signed(
                                                -61,16),to_signed(-63,16),to_signed(-64,16),to_signed(-65,16),to_signed(-65,16),to_signed(
                                                -66,16),to_signed(-67,16),to_signed(-67,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-67,16),to_signed(-66,16),to_signed(-65,16),to_signed(-64,16),to_signed(-63,16),to_signed(-62,16),to_signed(-60,16),to_signed(-58,16),to_signed(-56,16),to_signed(-54,16),to_signed(-52,16),to_signed(-49,16),to_signed(-46,16),to_signed(-43,16),to_signed(-40,16),to_signed(-36,16),to_signed(-33,16),to_signed(-29,16),to_signed(-25,16),to_signed(-20,16),to_signed(
                                                -16,16),to_signed(-11,16),to_signed(-6,16),to_signed(-1,16),to_signed(5,16),to_signed(10,16),to_signed(16,16),to_signed(22,16),to_signed(29,16),to_signed(35,16),to_signed(42,16),to_signed(49,16),to_signed(56,16),to_signed(64,16),to_signed(71,16),to_signed(79,16),to_signed(87,16),to_signed(95,16),to_signed(103,16),to_signed(111,16),to_signed(120,16),to_signed(128,16),to_signed(137,16),to_signed(146,16),to_signed(155,16),to_signed(164,16),to_signed(174,16),to_signed(183,16),to_signed(192,16),to_signed(202,16),to_signed(211,16),to_signed(221,16),to_signed(230,16),to_signed(240,16),to_signed(
                                                250,16),to_signed(259,16),to_signed(269,16),to_signed(279,16),to_signed(288,16),to_signed(298,16),to_signed(307,16),to_signed(317,16),to_signed(326,16),to_signed(336,16),to_signed(345,16),to_signed(354,16),to_signed(363,16),to_signed(372,16),to_signed(380,16),to_signed(389,16),to_signed(397,16),to_signed(405,16),to_signed(413,16),to_signed(421,16),to_signed(429,16),to_signed(436,16),to_signed(443,16),to_signed(450,16),to_signed(456,16),to_signed(463,16),to_signed(469,16),to_signed(475,16),to_signed(480,16),to_signed(485,16),to_signed(
                                                490,16),to_signed(495,16),to_signed(499,16),to_signed(503,16),to_signed(507,16),to_signed(510,16),to_signed(513,16),to_signed(516,16),to_signed(518,16),to_signed(520,16),to_signed(522,16),to_signed(523,16),to_signed(524,16),to_signed(524,16),to_signed(524,16),to_signed(524,16),to_signed(524,16),to_signed(523,16),to_signed(522,16),to_signed(520,16),to_signed(518,16),to_signed(516,16),to_signed(513,16),to_signed(510,16),to_signed(507,16),to_signed(503,16),to_signed(499,16),to_signed(495,16),to_signed(490,16),to_signed(485,16),to_signed(
                                                480,16),to_signed(475,16),to_signed(469,16),to_signed(463,16),to_signed(456,16),to_signed(450,16),to_signed(443,16),to_signed(436,16),to_signed(429,16),to_signed(421,16),to_signed(413,16),to_signed(405,16),to_signed(397,16),to_signed(389,16),to_signed(380,16),to_signed(372,16),to_signed(363,16),to_signed(354,16),to_signed(345,16),to_signed(336,16),to_signed(326,16),to_signed(317,16),to_signed(307,16),to_signed(298,16),to_signed(288,16),to_signed(279,16),to_signed(269,16),to_signed(259,16),to_signed(250,16),to_signed(240,16),to_signed(
                                                230,16),to_signed(221,16),to_signed(211,16),to_signed(202,16),to_signed(192,16),to_signed(183,16),to_signed(174,16),to_signed(164,16),to_signed(155,16),to_signed(146,16),to_signed(137,16),to_signed(128,16),to_signed(120,16),to_signed(111,16),to_signed(103,16),to_signed(95,16),to_signed(87,16),to_signed(79,16),to_signed(71,16),to_signed(64,16),to_signed(56,16),to_signed(49,16),to_signed(42,16),to_signed(35,16),to_signed(29,16),to_signed(22,16),to_signed(16,16),to_signed(10,16),to_signed(5,16),to_signed(-1,16),to_signed(-6,16),to_signed(-11,16),to_signed(-16,16),to_signed(-20,16),to_signed(
                                                -25,16),to_signed(-29,16),to_signed(-33,16),to_signed(-36,16),to_signed(-40,16),to_signed(-43,16),to_signed(-46,16),to_signed(-49,16),to_signed(-52,16),to_signed(-54,16),to_signed(-56,16),to_signed(-58,16),to_signed(-60,16),to_signed(-62,16),to_signed(-63,16),to_signed(-64,16),to_signed(-65,16),to_signed(-66,16),to_signed(-67,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-68,16),to_signed(-67,16),to_signed(-67,16),to_signed(-66,16),to_signed(-65,16),to_signed(
                                                -65,16),to_signed(-64,16),to_signed(-63,16),to_signed(-61,16),to_signed(-60,16),to_signed(-59,16),to_signed(-58,16),to_signed(-56,16),to_signed(-55,16),to_signed(-53,16),to_signed(-52,16),to_signed(-50,16),to_signed(-48,16),to_signed(-47,16),to_signed(-45,16),to_signed(-44,16),to_signed(-42,16),to_signed(-40,16),to_signed(-38,16),to_signed(-37,16),to_signed(-35,16),to_signed(-33,16),to_signed(-32,16),to_signed(-30,16),to_signed(-28,16),to_signed(-27,16),to_signed(-25,16),to_signed(-24,16),to_signed(-173,16));

    signal history : coef_array;
    signal data_sum : signed(31 downto 0);

begin
process(clock, reset)
begin
    if (reset = '1') then
        data_sum <= (others => '0');
        data_out <= (others => '0');
        for i in 0 to 276 loop
            history(i) <= (others => '0');
        end loop;
    elsif (rising_edge(clock)) then
        data_sum <= (others => '0');
        for i in 276 downto 1 loop
            history(i) <= history(i-1);
        end loop;
        history(0) <= signed(data_in);
        for i in 0 to 276 loop
            data_sum <= data_sum + (history(i) * coefficients(i));
        end loop;
        data_out <= std_logic_vector(data_sum(15 downto 0));
    end if;
end process;
end FIR_filter_arch;
