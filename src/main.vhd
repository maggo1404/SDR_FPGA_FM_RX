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
           reset_inv : in  STD_LOGIC;
           --adc_i : in  STD_LOGIC_VECTOR(7 downto 0);
           --adc_q : in  STD_LOGIC_VECTOR(7 downto 0);
           --oscillator_freq : in  STD_LOGIC_VECTOR(15 downto 0);
           --data_out : out  STD_LOGIC_VECTOR(7 downto 0);
           led_pin : out  STD_LOGIC_VECTOR(5 downto 0);
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
    attribute syn_dspstyle:string;
    attribute syn_dspstyle of mixer_i:signal is "logic";
    signal mixer_q : std_logic_vector(15 downto 0);
    signal filtered_i : std_logic_vector(15 downto 0);
    signal filtered_q : std_logic_vector(15 downto 0);
    signal down_i : std_logic_vector(15 downto 0);
    signal down_q : std_logic_vector(15 downto 0);
    signal down_i_t : std_logic_vector(7 downto 0);
    signal down_q_t : std_logic_vector(7 downto 0);
    signal down_valide : std_logic;
    signal down_valide_last : std_logic;
    signal fm_audio : std_logic_vector(7 downto 0);
    signal reset : STD_LOGIC;
    signal clk_data : STD_LOGIC;
    signal rx_data : std_logic_vector(7 downto 0);
    signal rx_data_vld : std_logic;
    signal rx_temp_clk : std_logic;
    

--   signal clk,rst : std_logic := '0';
    signal ftw : std_logic_vector(ftw_width-1 downto 0);
--    signal phase_out : std_logic_vector(phase_width-1 downto 0);
    signal ampl_out : std_logic_vector(ampl_width-1 downto 0);
    signal init_phase : std_logic_vector(phase_width-1 downto 0);
    signal ftw_hf : std_logic_vector(ftw_width-1 downto 0);

begin

	dds_synth: dds_synthesizer
  generic map(
		ftw_width   => ftw_width
  )
  port map(
		clk_i => clk_data,
		rst_i => reset,
		ftw_i    => ftw,
		phase_i  => init_phase,
		ampl_o => ampl_out
  );

    filter_i: FIR_filter
    port map(
        clock => clk_data,
        reset => reset,
        data_in => mixer_i,
        data_out => filtered_i
    );

    filter_q: FIR_filter
    port map(
        clock => clk_data,
        reset => reset,
        data_in => mixer_q,
        data_out => filtered_q
    );

    downsampler_i: downsampler
    port map(
        clk => clk_data,
        reset => reset,
        input => filtered_i,
        output => down_i,
        output_valid => down_valide
        );

    downsampler_q: downsampler
    port map(
        clk => clk_data,
        reset => reset,
        input => filtered_q,
        output => down_q
        --output_valid => down_valide
        );

    FMdemod: FM_demod
    port map(
        i_i => down_i_t,
        i_q => down_q_t,
--        i_in => down_i(15 downto 8),
--        q_in => down_q(15 downto 8),
        i_clk => clk_data, --down_valide,
        o_audio => fm_audio,--data_out
        i_reset => reset
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
        --DATA_IN         => rx_data, --data_out, --data,
        --DATA_SEND      => rx_data_vld, --valid,
        BUSY       => open,
        -- USER DATA OUTPUT INTERFACE
        DATA_OUT         => rx_data,--data,
        DATA_VLD     => rx_data_vld,--valid,
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

    --process (down_valide, fm_audio)
    --begin
    --    led_pin <= fm_audio(5 downto 0);
    --end process;
    --process (clk_main)
    --begin
    --    led_pin <= ampl_out(ampl_width - 1 downto ampl_width - 6);
    --end process;


-- f=ftw_i/2^ftw_width*fclk
-- ftwi = (f * 2^ftw_width) / fclk 
-- soll 200khz 
-- ist 199999.996461 khz
	--ftw <= conv_std_logic_vector(31814572,ftw_width);  --20us period @ 27MHz, ftw_width=32
    --ftw <= conv_std_logic_vector(318,ftw_width);  --2hz period @ 27MHz, ftw_width=32
    --ftw <= conv_std_logic_vector(751619276,ftw_width);  --350khz period @ 2MHz, ftw_width=32, ist 349999,99962747097015380859375
    ftw <= conv_std_logic_vector(429496729,ftw_width);  --200khz period @ 2MHz, ftw_width=32, ist 349999,99962747097015380859375
    init_phase <= (others => '0');

    process (rx_data_vld)
    begin
        if rx_data_vld'event and rx_data_vld = '1' then
            if clk_data = '0' then
                --down_i_t <= rx_data;
                --down_i_t <= std_logic_vector(resize(signed(rx_data), down_i_t'length));
                down_i_t <= rx_data;
                clk_data <= '1';
            else 
                --down_q_t <= rx_data;
                --down_q_t <= std_logic_vector(resize(signed(rx_data), down_q_t'length));
                down_q_t <= rx_data;
                clk_data <= '0';
            end if;
            
        end if;
    end process;

    process (clk_data)
    begin
        if clk_data'event and clk_data = '1' then
            mixer_i <= adc_i * ampl_out;
            mixer_q <= adc_q * ampl_out;

            --out_q <= down_i;
            --out_i <= down_q;
        end if;
    end process;
    
    process(reset_inv)
    begin
        reset <= not reset_inv;
    end process;

end Behavioral;


