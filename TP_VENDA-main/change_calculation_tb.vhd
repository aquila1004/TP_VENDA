library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation_tb is
end entity change_calculation_tb;

architecture behavioral of change_calculation_tb is
    -- Componente a ser testado
    component change_calculation
        port (
            productPrice: in unsigned(3 downto 0);
            coinSum: in unsigned(6 downto 0);
            change: inout unsigned(6 downto 0);
            segmentA: out std_logic;
            segmentB: out std_logic;
            segmentC: out std_logic;
            segmentD: out std_logic;
            segmentE: out std_logic;
            segmentF: out std_logic;
            segmentG: out std_logic
        );
    end component change_calculation;

    -- Sinais de entrada
    signal productPrice_tb : unsigned(3 downto 0) := "0000";
    signal coinSum_tb     : unsigned(6 downto 0) := "0000000";

    -- Sinais de saída
    signal change_tb      : unsigned(6 downto 0);
    signal segmentA_tb    : std_logic;
    signal segmentB_tb    : std_logic;
    signal segmentC_tb    : std_logic;
    signal segmentD_tb    : std_logic;
    signal segmentE_tb    : std_logic;
    signal segmentF_tb    : std_logic;
    signal segmentG_tb    : std_logic;

begin
    -- Instanciar o componente a ser testado
    dut : change_calculation
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
            segmentG => segmentG_tb
        );

    -- Processo de estimulação
    stim_proc: process
    begin
        -- Estimular os sinais de entrada
        productPrice_tb <= "0000";
        coinSum_tb     <= "0000000";
        wait for 10 ns;

        productPrice_tb <= "0000";
        coinSum_tb     <= "0000001";
        wait for 10 ns;

        productPrice_tb <= "0001";
        coinSum_tb     <= "0000001";
        wait for 10 ns;

        productPrice_tb <= "0010";
        coinSum_tb     <= "0000010";
        wait for 10 ns;

        wait;
    end process;

end architecture behavioral;
