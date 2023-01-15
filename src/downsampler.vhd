library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use IEEE.STD_LOGIC_arith.all;
--use IEEE.STD_LOGIC_unsigned.all;


package downsampler_pkg is
  component downsampler
    port(
        clk : in std_logic;
        reset : in std_logic;
        input : in std_logic_vector(15 downto 0);
        output : out std_logic_vector(15 downto 0);
        output_valid : out std_logic
        );
  end component;
end downsampler_pkg;

package body downsampler_pkg is
end downsampler_pkg;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity downsampler is
  port (
    clk : in std_logic;
    reset : in std_logic;
    input : in std_logic_vector(15 downto 0);
    output : out std_logic_vector(15 downto 0);
    output_valid : out std_logic
  );
end downsampler;

architecture rtl of downsampler is
  signal counter : unsigned(6 downto 0);
  signal output_tmp : std_logic_vector(15 downto 0);
begin
  -- Downsampling process
  process(clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        counter <= (others => '0');
        output <= (others => '0');
        output_valid <= '0';
      else
        counter <= counter + 1;
        if counter = 83 then
          counter <= (others => '0');
          output <= input;
          output_valid <= '1';
        end if;
        if counter = 42 then
          output_valid <= '0';
        end if;
      end if;
    end if;
  end process;

  ---- Output logic
  --output <= output_tmp;
  --process(output_valid, clk)
  --begin
    --if output_valid = '1' then
        --if rising_edge(clk) then
            --output_valid <= '0';
        --end if;
    --end if;
  --end process;
end rtl;
