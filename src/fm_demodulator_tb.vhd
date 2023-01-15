library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fm_demod_tb is
end fm_demod_tb;

architecture behavior of fm_demod_tb is
    -- Declare the component being tested
    component FM_demod
        port(
            i_in : in std_logic_vector(7 downto 0); -- IQ input
            q_in : in std_logic_vector(7 downto 0); -- IQ input
            clk : in std_logic; -- clock signal
            demod_out : out std_logic_vector(7 downto 0) -- demodulated output
        );
    end component;

    -- Declare the testbench signals
    signal i_in : std_logic_vector(7 downto 0) := (others => '0');
    signal q_in : std_logic_vector(7 downto 0) := (others => '0');
    signal clk : std_logic := '0';
    signal demod_out : std_logic_vector(7 downto 0);

    -- Declare a signal to hold the expected output
    signal expected_demod_out : std_logic_vector(7 downto 0);
begin
    -- Instantiate the component being tested
    dut: FM_demod
        port map (
            i_in => i_in,
            q_in => q_in,
            clk => clk,
            demod_out => demod_out
        );

    -- Generate a clock signal with 50% duty cycle
    clock_process : process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process;

    -- Test case 1: Set the input signals to a known value and check the output
    test_case_1 : process
    begin
        -- Set the input values
        i_in <= "01010101";
        q_in <= "10101010";

        -- Wait for 1 clock cycle to allow the output to stabilize
        wait for 10 ns;
	 i_in <= "11110000";
         q_in <= "00001111";
        -- Calculate the expected output
       -- expected_demod_out <= std_logic_vector(to_unsigned((to_integer(unsigned(i_in)) * ((to_integer(unsigned(i_in)) * to_integer(unsigned(i_in))) + (to_integer(unsigned(q_in)) * to_integer(unsigned(q_
	-- intermediate_value := to_integer(unsigned(i_in)) * to_integer(unsigned(i_in)) + to_integer(unsigned(q_in)) * to_integer(unsigned(q_in));
        --expected_demod_out <= std_logic_vector(unsigned(to_integer(unsigned(i_in)) * intermediate_value + to_integer(unsigned(q_in)) * intermediate_value),demod_out'length);
    -- Compare the output to the expected value
    --assert demod_out = expected_demod_out report "Unexpected output in test case 1" severity failure;

    -- Wait for another clock cycle to allow the output to stabilize
    wait for 10 ns;
end process;

-- Test case 2: Set the input signals to a different known value and check the output
--test_case_2 : process
--begin
    -- Set the input values
    --i_in <= "11110000";
    --q_in <= "00001111";

    -- Wait for 1 clock cycle to allow the output to stabilize
    --wait for 10 ns;

    -- Calculate the expected output
--    expected_demod_out <= std_logic_vector(to_unsigned((to_integer(unsigned(i_in)) * ((to_integer(unsigned(i_in)) * to_integer(unsigned(i_in))) + (to_integer(unsigned(q_in)) * to_integer(unsigned(q_in)))) + (to_integer(unsigned(q_in)) * ((to_integer(unsigned(i_in)) * to_integer(unsigned(i_in))) + (to_integer(unsigned(q_in)) * to_integer(unsigned(q_in)))), demod_out'length);

    -- Compare the output to the expected value
--    assert demod_out = expected_demod_out report "Unexpected output in test case 2" severity failure;

    -- Wait for another clock cycle to allow the output to stabilize
    --wait for 10 ns;
--end process;

end behavior;

