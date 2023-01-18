-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 18.1.2023 19:23:37 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_SDR_Main is
end tb_SDR_Main;

architecture tb of tb_SDR_Main is

    component SDR_Main
        port (clk_main : in std_logic;
              reset    : in std_logic;
              data_out : out std_logic_vector (7 downto 0));
    end component;

    signal clk_main : std_logic;
    signal reset    : std_logic;
    signal data_out : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : SDR_Main
    port map (clk_main => clk_main,
              reset    => reset,
              data_out => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk_main is really your main clock signal
    clk_main <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

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

configuration cfg_tb_SDR_Main of tb_SDR_Main is
    for tb
    end for;
end cfg_tb_SDR_Main;
