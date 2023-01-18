-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 18.1.2023 19:05:09 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_mixer_osc is
end tb_mixer_osc;

architecture tb of tb_mixer_osc is

    component mixer_osc
        port (clk             : in std_logic;
              reset           : in std_logic;
              adc_in          : in std_logic_vector (15 downto 0);
              oscillator_freq : in std_logic_vector (15 downto 0);
              mixer_out       : out std_logic_vector (15 downto 0));
    end component;

    signal clk             : std_logic;
    signal reset           : std_logic;
    signal adc_in          : std_logic_vector (15 downto 0);
    signal oscillator_freq : std_logic_vector (15 downto 0);
    signal mixer_out       : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : mixer_osc
    port map (clk             => clk,
              reset           => reset,
              adc_in          => adc_in,
              oscillator_freq => oscillator_freq,
              mixer_out       => mixer_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        adc_in <= (others => '0');
        oscillator_freq <= (others => '0');

        -- Reset generation
        -- EDIT: Check that reset is really your reset signal
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_mixer_osc of tb_mixer_osc is
    for tb
    end for;
end cfg_tb_mixer_osc;
