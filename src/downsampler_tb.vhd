library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity downsampler_tb is
end downsampler_tb;

architecture test of downsampler_tb is
signal clk : std_logic := '0';
signal reset : std_logic := '0';
signal input : std_logic_vector(15 downto 0);
signal output : std_logic_vector(15 downto 0);
signal output_valid : std_logic;

begin

-- Instantiate the DUT
dut: entity work.downsampler
port map (
clk => clk,
reset => reset,
input => input,
output => output,
output_valid => output_valid
);

-- Clock generator
clk_gen: process
begin
clk <= '0';
wait for 10 ns;
clk <= '1';
wait for 10 ns;
end process;

-- Reset generator
reset_gen: process
begin
reset <= '1';
wait for 20 ns;
reset <= '0';
wait;
end process;

-- Input generator
input_gen: process
begin
input <= "0000000000000000";
wait for 20 ns;
input <= "0000000000000001";
wait for 20 ns;
input <= "0000000000000010";
wait for 20 ns;
input <= "0000000000000011";
wait for 20 ns;
input <= "0000000000000100";
wait for 20 ns;
input <= "0000000000000101";
wait for 20 ns;
input <= "0000000000000110";
wait for 20 ns;
input <= "0000000000000111";
wait for 20 ns;
input <= "0000000000001000";
wait for 20 ns;
input <= "0000000000001001";
wait for 20 ns;
input <= "0000000000001010";
wait for 20 ns;
input <= "0000000000001011";
wait for 20 ns;
input <= "0000000000001100";
wait for 20 ns;
input <= "0000000000001101";
wait for 20 ns;
input <= "0000000000001110";
wait for 20 ns;
input <= "0000000000001111";
wait for 20 ns;
input <= "0000000000010000";
wait for 20 ns;
input <= "0000000000010001";
wait for 20 ns;
input <= "0000000000010010";
wait for 20 ns;
input <= "0000000000010011";
wait for 20 ns;
input <= "0000000000010100";
wait for 20 ns;
input <= "0000000000010101";
wait for 20 ns;
input <= "0000000000010110";
wait for 20 ns;
input <= "0000000000010111";
wait for 20 ns;
input <= "0000000000011000";
wait for 20 ns;
input <= "0000000000011001";
wait for 20 ns;
input <= "0000000000011010";
wait for 20 ns;
input <= "0000000000011011";
wait for 20 ns;
input <= "0000000000011100";
wait for 20 ns;
input <= "0000000000011101";
wait for 20 ns;
input <= "0000000000011110";
wait for 20 ns;
input <= "0000000000011111";
wait for 20 ns;
input <= "0000000000100000";
wait for 20 ns;
input <= "0000000000100001";
wait for 20 ns;
input <= "0000000000100010";
wait for 20 ns;
input <= "0000000000100011";
wait for 20 ns;
input <= "0000000000100100";
wait for 20 ns;
input <= "0000000000100101";
wait for 20 ns;
input <= "0000000000100110";
wait for 20 ns;
input <= "0000000000100111";
wait for 20 ns;
input <= "0000000000101000";
wait for 20 ns;
input <= "0000000000101001";
wait for 20 ns;
input <= "0000000000101010";
wait for 20 ns;
input <= "0000000000101011";
wait for 20 ns;
input <= "0000000000101100";
wait for 20 ns;
input <= "0000000000101101";
wait for 20 ns;
input <= "0000000000101110";
wait for 20 ns;
input <= "0000000000101111";
wait for 20 ns;
input <= "0000000000110000";
wait for 20 ns;
input <= "0000000000110001";
wait for 20 ns;
input <= "0000000000110010";
wait for 20 ns;
input <= "0000000000110011";
wait for 20 ns;
input <= "0000000000110100";
wait for 20 ns;
input <= "0000000000110101";
wait for 20 ns;
input <= "0000000000110110";
wait for 20 ns;
input <= "0000000000110111";
wait for 20 ns;
input <= "0000000000111000";
wait for 20 ns;
input <= "0000000000111001";
wait for 20 ns;
input <= "0000000000111010";
wait for 20 ns;
input <= "0000000000111011";
wait for 20 ns;
input <= "0000000000111100";
wait for 20 ns;
input <= "0000000000111101";
wait for 20 ns;
input <= "0000000000111110";
wait for 20 ns;
input <= "0000000000111111";
wait for 20 ns;
input <= "0000000001000000";
wait for 20 ns;
input <= "0000000001000001";
wait for 20 ns;
input <= "0000000001000010";
wait for 20 ns;
input <= "0000000001000011";
wait for 20 ns;
input <= "0000000001000100";
wait for 20 ns;
input <= "0000000001000101";
wait for 20 ns;
input <= "0000000001000110";
wait for 20 ns;
input <= "0000000001000111";
wait for 20 ns;
input <= "0000000001001000";
wait for 20 ns;
input <= "0000000001001001";
wait for 20 ns;
input <= "0000000001001010";
wait for 20 ns;
input <= "0000000001001011";
wait for 20 ns;
input <= "0000000001001100";
wait for 20 ns;
input <= "0000000001001101";
wait for 20 ns;
input <= "0000000001001110";
wait for 20 ns;
input <= "0000000001001111";
wait for 20 ns;
input <= "0000000001010000";
wait for 20 ns;
input <= "0000000001010001";
wait for 20 ns;
input <= "0000000001010010";
wait for 20 ns;
input <= "0000000001010011";
wait for 20 ns;
input <= "0000000001010100";
wait for 20 ns;
input <= "0000000001010101";
wait for 20 ns;
input <= "0000000001010110";
wait for 20 ns;
input <= "0000000001010111";
wait for 20 ns;
input <= "0000000001011000";
wait for 20 ns;
input <= "0000000001011001";
-- ... and so on
end process;

-- Test case 1: Check that output is valid every 83rd clock cycle
test1: process
begin
wait for 83 * 10 ns;
--assert output_valid = '1' report "Output not valid on 83rd cycle" severity failure;
wait for 10 ns;
--assert output_valid = '0' report "Output still valid after 83rd cycle" severity failure;
wait for 83 * 10 ns;
--assert output_valid = '1' report "Output not valid on 166th cycle" severity failure;
wait for 10 ns;
--assert output_valid = '0' report "Output still valid after 166th cycle" severity failure;
-- ... and so on
end process;

-- Test case 2: Check that output matches input every 83rd cycle
test2: process
begin
wait for 83 * 10 ns;
--assert output = input report "Output does not match input on 83rd cycle" severity failure;
wait for 83 * 10 ns;
--assert output = input report "Output does not match input on 166th cycle" severity failure;
-- ... and so on
end process;

end test;