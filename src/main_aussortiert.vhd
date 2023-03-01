    signal ftw_nf : std_logic_vector(ftw_width-1 downto 0);
    signal ftw_hf : std_logic_vector(ftw_width-1 downto 0);
    signal init_phase : std_logic_vector(phase_width-1 downto 0);
    signal init_phase90 : std_logic_vector(phase_width-1 downto 0);
    signal ampl_nf : std_logic_vector(ampl_width-1 downto 0);
    ftw_nf <= conv_std_logic_vector(318145,ftw_width); --2khz


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







process (ampl_nf)
    begin
        --if ampl_nf'event then
        ftw_hf <= (ampl_nf * conv_std_logic_vector(3106,8)) + conv_std_logic_vector(31019208,ftw_width);
        --end if;
    end process;


    
    init_phase90 <= conv_std_logic_vector(1024,phase_width);