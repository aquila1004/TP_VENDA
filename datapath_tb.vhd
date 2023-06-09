library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity datapath_tb is
end entity datapath_tb;

architecture testbench of datapath_tb is
    constant DATA_WIDTH: natural := 7;

    signal coinSum_tb: unsigned(DATA_WIDTH-1 downto 0);
    signal reset_tb: std_logic := '0';

    component datapath
        generic (
            DATA_WIDTH: natural := 7
        );
        port (
            pino4: in std_logic;
            pino5: in std_logic;
            pino6: in std_logic;
            pino7: in std_logic;
            coinSum: inout unsigned(DATA_WIDTH-1 downto 0);
            reset: in std_logic
        );
    end component datapath;

begin
    dut: datapath
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            pino4 => '0',
            pino5 => '0',
            pino6 => '0',
            pino7 => '0',
            coinSum => coinSum_tb,
            reset => reset_tb
        );

    stimulus: process
    begin
        -- Test case 1
        reset_tb <= '1';
        wait for 10 ns;
        assert coinSum_tb = to_unsigned(0, DATA_WIDTH) report "Test case 1 failed: Incorrect coinSum value" severity error;
        reset_tb <= '0';
        wait for 10 ns;

        -- Test case 2
        wait for 10 ns;
        assert coinSum_tb = to_unsigned(1, DATA_WIDTH) report "Test case 2 failed: Incorrect coinSum value" severity error;
        wait for 10 ns;

        -- Test case 3
        wait for 10 ns;
        assert coinSum_tb = to_unsigned(3, DATA_WIDTH) report "Test case 3 failed: Incorrect coinSum value" severity error;
        wait for 10 ns;

        -- Test case 4
        wait for 10 ns;
        assert coinSum_tb = to_unsigned(6, DATA_WIDTH) report "Test case 4 failed: Incorrect coinSum value" severity error;
        wait;

    end process stimulus;
end architecture testbench;
