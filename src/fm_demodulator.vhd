library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package FM_demod_pkg is
  component FM_demod
    port(
        i_in : in std_logic_vector(7 downto 0); -- IQ input
        q_in : in std_logic_vector(7 downto 0); -- IQ input
        clk : in std_logic; -- clock signal
        demod_out : out std_logic_vector(7 downto 0) -- demodulated output
      );

  end component;
end FM_demod_pkg;

package body FM_demod_pkg is
end FM_demod_pkg;



-- FM Demodulator with IQ input
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity FM_demod is
    port(
        i_in : in std_logic_vector(7 downto 0); -- IQ input
        q_in : in std_logic_vector(7 downto 0); -- IQ input
        clk : in std_logic; -- clock signal
        demod_out : out std_logic_vector(7 downto 0) -- demodulated output
    );
end FM_demod;

architecture behavior of FM_demod is
    signal i, q : integer range 0 to 255; -- in-phase and quadrature-phase signals
    signal carrier : integer range 0 to 131072;--65535; -- carrier signal
    signal demod_sig : integer range 0 to 33554431; --65535; -- demodulated signal
begin
    -- split IQ input into in-phase and quadrature-phase signals
    i <= to_integer(unsigned(i_in));
    q <= to_integer(unsigned(q_in));

    -- generate carrier signal using PLL
    process(clk)
    begin
        if rising_edge(clk) then
            carrier <= (i * i) + (q * q);
        end if;
    end process;

    -- demodulate using detector
    process(clk)
    begin
        if rising_edge(clk) then
            demod_sig <= (i * carrier) + (q * carrier);
        end if;
    end process;

    -- convert demodulated signal to output format
    -- demod_out <= conv_std_logic_vector(demod_sig, demod_out'length);
    demod_out <= std_logic_vector(to_unsigned(demod_sig, demod_out'length));
end behavior;

