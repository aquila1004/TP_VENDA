library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation_tb is
end entity change_calculation_tb;

architecture tb_architecture of change_calculation_tb is
    -- Component declaration
    component change_calculation is
        port (
            productPrice: in unsigned(7 downto 0);
            coinSum: in unsigned(7 downto 0);
            change: out unsigned(7 downto 0);
            segmentA: out std_logic;
            segmentB: out std_logic;
            segmentC: out std_logic;
            segmentD: out std_logic;
            segmentE: out std_logic;
            segmentF: out std_logic;
            segmentG: out std_logic;
            enable: in std_logic
        );
    end component change_calculation;

    -- Signals
    signal productPrice_tb: unsigned(7 downto 0);
    signal coinSum_tb: unsigned(7 downto 0);
    signal change_tb: unsigned(7 downto 0);
    signal segmentA_tb: std_logic;
    signal segmentB_tb: std_logic;
    signal segmentC_tb: std_logic;
    signal segmentD_tb: std_logic;
    signal segmentE_tb: std_logic;
    signal segmentF_tb: std_logic;
    signal segmentG_tb: std_logic;
    signal enable_tb: std_logic;

begin
    -- Instantiate the component
    uut: change_calculation
    port map (
        productPrice => productPrice_tb,
        coinSum => coinSum_tb,
        change => change_tb,
        segmentA => segmentA_tb,
        segmentB => segmentB_tb,
        segmentC => segmentC_tb,
        segmentD => segmentD_tb,
        segmentE => segmentE_tb,
        segmentF => segmentF_tb,
        segmentG => segmentG_tb,
        enable => enable_tb
    );

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1
        productPrice_tb <= "00000010";
        coinSum_tb <= "00000110";
        enable_tb <= '1';
        wait for 10 ns;

        -- Test case 2
        productPrice_tb <= "00000011";
        coinSum_tb <= "00000001";
        enable_tb <= '1';
        wait for 10 ns;

        -- Test case 3
        productPrice_tb <= "00000101";
        coinSum_tb <= "00000110";
        enable_tb <= '0';
        wait for 10 ns;

        -- Add more test cases here...

        -- End the simulation
        wait;
    end process;

end architecture tb_architecture;
