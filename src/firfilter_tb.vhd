library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity firfilter_tb is
end entity firfilter_tb;

-- Declare the testbench architecture
architecture tb of firfilter_tb is
  -- Declare signals for the input and output of the FIR_filter
  signal clock : std_logic;
  signal reset : std_logic;
  signal data_in : std_logic_vector(15 downto 0);
  signal data_out : std_logic_vector(15 downto 0);
  subtype std_logic_vectortype is std_logic_vector(15 downto 0);
  type std_logic_vector_file is file of std_logic_vectortype;
  file output : std_logic_vector_file;
begin
  -- Instantiate the FIR_filter module
  uut : entity work.FIR_filter
    port map (
      clock => clock,
      reset => reset,
      data_in => data_in,
      data_out => data_out
    );

  FILE_OPEN(output,"output.txt",WRITE_MODE);
  -- Create a clock signal with a 50% duty cycle and a 10 ns period
  clocking : process
  begin
    clock <= '0';
    write(output, data_out);
    wait for 5 ns;
    clock <= '1';
    wait for 5 ns;
  end process;

  resting : process
  begin
    -- Initialize the reset signal to '1' and wait for 100 ns
    reset <= '1';
    wait for 100 ns;

    -- Set the reset signal to '0'
    reset <= '0';
    wait;
  end process;

  -- Stimulus process
  stim_proc : process
  begin
    -- Wait for 1 clock cycle
    wait for 100 ns;

    -- Assign a test input vector to the data_in signal
    data_in <= "0011111111111111";

    -- Wait for 10 clock cycles
    wait for 100 ns;

    -- Assign a different test input vector to the data_in signal
    data_in <= "0000000000000000";

    -- Wait for 10 clock cycles
    -- wait for 100 ns;

    -- Assign another test input vector to the data_in signal
    -- data_in <= "0000000000000100";

    -- Wait for 10 clock cycles
    --wait for 100 ns;

    -- Assign yet another test input vector to the data_in signal
    -- data_in <= "0000000000001000";

    -- Wait for 10 clock cycles
    -- wait for 100 ns;

    -- data_in <= "0000000000001000"

    -- Stop the stimulus process
    -- wait;
  end process;
end;
