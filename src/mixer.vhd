library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Mixer with local oscillator entity
entity mixer_osc is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           adc_in : in  STD_LOGIC_VECTOR(15 downto 0);
           oscillator_freq : in  STD_LOGIC_VECTOR(15 downto 0);
           mixer_out : out  STD_LOGIC_VECTOR(15 downto 0));
end mixer_osc;

-- Mixer with local oscillator architecture
architecture Behavioral of mixer_osc is
    signal oscillator : std_logic_vector(15 downto 0);
    signal mixer : std_logic_vector(15 downto 0);

begin
    -- Generate local oscillator signal
    process(clk, reset)
    begin
        if reset = '1' then
            oscillator <= (others => '0');
        elsif rising_edge(clk) then
            oscillator <= std_logic_vector(sin(real(oscillator_freq)));
        end if;
    end process;

    -- Mix input signal and local oscillator signal
    mixer <= adc_in * oscillator;

    -- Low-pass filter mixed signal to select desired frequency range
    process(clk, reset)
    begin
        if reset = '1' then
            mixer_out <= (others => '0');
        elsif rising_edge(clk) then
            mixer_out <= mixer_out + mixer;
        end if;
    end process;
end Behavioral;
