-- Testbench of DDS Frequency Synthesizer
--
-- Copyright (C) 2009 Martin Kumm
-- 
-- This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License along with this program; 
-- if not, see <http://www.gnu.org/licenses/>.

-- Package Definition

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;
use work.dds_synthesizer_pkg.all;
use work.sine_lut_pkg.all;
use work.FIR_filter_pkg.all;
use work.downsampler_pkg.all;
use work.FM_demod_pkg.all;
use work.UART_pkg.all;

-- Mixer with local oscillator entity
entity SDR_Main is
    generic(
        ftw_width : integer := 32
        -- UART
        --CLK_FREQ   : integer := 27e6;   -- set system clock frequency in Hz
        --BAUD_RATE  : integer := 115200; -- baud rate value
        --PARITY_BIT : string  := "none"  -- legal values: "none", "even", "odd", "mark", "space"
   );
    Port ( clk_main : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           --adc_i : in  STD_LOGIC_VECTOR(7 downto 0);
           --adc_q : in  STD_LOGIC_VECTOR(7 downto 0);
           --oscillator_freq : in  STD_LOGIC_VECTOR(15 downto 0);
           --data_out : out  STD_LOGIC_VECTOR(7 downto 0);
           --out_q : out  STD_LOGIC_VECTOR(15 downto 0);
           --out_i : out  STD_LOGIC_VECTOR(15 downto 0)
           uart_out_pin : out STD_LOGIC;
           uart_in_pin : in STD_LOGIC
    );

end SDR_Main;

-- Mixer with local oscillator architecture
architecture Behavioral of SDR_MAIN is
--    signal oscillator : std_logic_vector(15 downto 0);
--    signal mixer : std_logic_vector(15 downto 0);


    signal adc_i : std_logic_vector(7 downto 0);
    signal adc_q : std_logic_vector(7 downto 0);
    signal mixer_i : std_logic_vector(15 downto 0);
    signal mixer_q : std_logic_vector(15 downto 0);
    signal filtered_i : std_logic_vector(15 downto 0);
    signal filtered_q : std_logic_vector(15 downto 0);
    signal down_i : std_logic_vector(15 downto 0);
    signal down_q : std_logic_vector(15 downto 0);
    signal down_valide : std_logic;
    signal fm_audio : std_logic_vector(7 downto 0);

--   signal clk,rst : std_logic := '0';
    signal ftw : std_logic_vector(ftw_width-1 downto 0);
    signal ftw_nf : std_logic_vector(ftw_width-1 downto 0);
    signal ftw_hf : std_logic_vector(ftw_width-1 downto 0);
    signal init_phase : std_logic_vector(phase_width-1 downto 0);
    signal init_phase90 : std_logic_vector(phase_width-1 downto 0);
--    signal phase_out : std_logic_vector(phase_width-1 downto 0);
    signal ampl_out : std_logic_vector(ampl_width-1 downto 0);
    signal ampl_nf : std_logic_vector(ampl_width-1 downto 0);

begin

	dds_synth: dds_synthesizer
  generic map(
		ftw_width   => ftw_width
  )
  port map(
		clk_i => clk_main,
		rst_i => reset,
		ftw_i    => ftw,
		phase_i  => init_phase,
		ampl_o => ampl_out
  );
	dds_synth_nf: dds_synthesizer
  generic map(
		ftw_width   => ftw_width
  )
  port map(
		clk_i => clk_main,
		rst_i => reset,
		ftw_i    => ftw_nf,
		phase_i  => init_phase,
		ampl_o => ampl_nf
  );
	dds_synth_hf: dds_synthesizer
  generic map(
		ftw_width   => ftw_width
  )
  port map(
		clk_i => clk_main,
		rst_i => reset,
		ftw_i    => ftw_hf,
		phase_i  => init_phase,
		ampl_o => adc_i
  );
    dds_synth_hf90: dds_synthesizer
  generic map(
		ftw_width   => ftw_width
  )
  port map(
		clk_i => clk_main,
		rst_i => reset,
		ftw_i    => ftw_hf,
		phase_i  => init_phase90,
		ampl_o => adc_q
  );

    filter_i: FIR_filter
    port map(
        clock => clk_main,
        reset => reset,
        data_in => mixer_i,
        data_out => filtered_i
    );

    filter_q: FIR_filter
    port map(
        clock => clk_main,
        reset => reset,
        data_in => mixer_q,
        data_out => filtered_q
    );

    downsampler_i: downsampler
    port map(
        clk => clk_main,
        reset => reset,
        input => filtered_i,
        output => down_i,
        output_valid => down_valide
        );

    downsampler_q: downsampler
    port map(
        clk => clk_main,
        reset => reset,
        input => filtered_q,
        output => down_q
        --output_valid => down_valide
        );

    FMdemod: FM_demod
    port map(
        i_in => down_i(15 downto 8),
        q_in => down_q(15 downto 8),
        clk => down_valide,
        demod_out => fm_audio--data_out
      );

    uart_i: entity work.UART
    port map (
        CLK          => clk_main,
        RST          => reset,
        -- UART INTERFACE
        UART_TXD     => uart_out_pin,
        UART_RXD     => uart_in_pin, --UART_RXD,
        -- USER DATA INPUT INTERFACE
        DATA_IN         => fm_audio, --data_out, --data,
        DATA_SEND      => down_valide, --valid,
        BUSY       => open,
        -- USER DATA OUTPUT INTERFACE
        DATA_OUT         => open,--data,
        DATA_VLD     => open,--valid,
        FRAME_ERROR  => open
        --PARITY_ERROR => open
        --DATA_IN     : in  std_logic_vector(7 downto 0);
        --DATA_SEND   : in  std_logic; -- when DATA_SEND = 1, data on DATA_IN will be transmit, DATA_SEND can set to 1 only when BUSY = 0
        --BUSY        : out std_logic; -- when BUSY = 1 transiever is busy, you must not set DATA_SEND to 1
        -- USER DATA OUTPUT INTERFACE
        --DATA_OUT    : out std_logic_vector(7 downto 0);
        --DATA_VLD    : out std_logic; -- when DATA_VLD = 1, data on DATA_OUT are valid
        --FRAME_ERROR : out std_logic  -- when FRAME_ERROR = 1, stop bit was invalid, current and next data may be invalid

    );


-- f=ftw_i/2^ftw_width*fclk
-- ftwi = (f * 2^ftw_width) / fclk
-- soll 200khz 
-- ist 199999.996461 khz
	ftw <= conv_std_logic_vector(31814572,ftw_width);  --20us period @ 100MHz, ftw_width=32
    ftw_nf <= conv_std_logic_vector(318145,ftw_width); --2khz

    init_phase <= (others => '0');
    init_phase90 <= conv_std_logic_vector(1024,phase_width);

    process (ampl_nf)
    begin
        --if ampl_nf'event then
        ftw_hf <= (ampl_nf * conv_std_logic_vector(3106,8)) + conv_std_logic_vector(31019208,ftw_width);
        --end if;
    end process;
    
        
    process (clk_main)
    begin
        if clk_main'event and clk_main = '1' then
            mixer_i <= adc_i * ampl_out;
            mixer_q <= adc_q * ampl_out;

            --out_q <= down_i;
            --out_i <= down_q;
        end if;
    end process;
end Behavioral;


