library IEEE;
use IEEE.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture tb_arch of fsm_tb is

    -- Constants
    constant CLK_PERIOD : time := 10 ns;

    -- Signals
    signal pin01, pin02, pin03, pin04, pin05, pin06, pin07, pin08, pin09, clk, enter, change_display, dispenser_display : std_logic;
    signal s : std_logic;

    component fsm 
        port (
            pin01             : IN STD_LOGIC;
            pin02             : IN STD_LOGIC;
            pin03             : IN STD_LOGIC;
            pin04             : IN STD_LOGIC;
            pin05             : IN STD_LOGIC;
            pin06             : IN STD_LOGIC;
            pin07             : IN STD_LOGIC;
            pin08             : IN STD_LOGIC; -- reset clock
            pin09             : IN STD_LOGIC; -- reset geral
            clk               : IN STD_LOGIC; -- clock
            enter             : IN STD_LOGIC; -- enter
            change_display    : OUT STD_LOGIC;
            dispenser_display : OUT STD_LOGIC;
            segment_displayA  : OUT STD_LOGIC;
            segment_displayB  : OUT STD_LOGIC;
            segment_displayC  : OUT STD_LOGIC;
            segment_displayD  : OUT STD_LOGIC;
            segment_displayE  : OUT STD_LOGIC;
            segment_displayF  : OUT STD_LOGIC;
            segment_displayG  : OUT STD_LOGIC;
    
            --Saida da fsm
            s : OUT STD_LOGIC
        );
    end component;
begin

    -- Instantiate the DUT
    dut : fsm
        port map (
            pin01 => pin01,
            pin02 => pin02,
            pin03 => pin03,
            pin04 => pin04,
            pin05 => pin05,
            pin06 => pin06,
            pin07 => pin07,
            pin08 => pin08,
            pin09 => pin09,
            clk => clk,
            enter => enter,
            change_display => change_display,
            dispenser_display => dispenser_display,
            --segmento_display => (others => '0'),
            s => s
        );

    -- Clock process
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD / 2;
        clk <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Stimulus process
    stimulus_process : process
    begin

        -- Initialize inputs
        pin01 <= '0';
        pin02 <= '0';
        pin03 <= '0';
        pin04 <= '0';
        pin05 <= '0';
        pin06 <= '0';
        pin07 <= '0';
        pin08 <= '0';
        pin09 <= '0';
        enter <= '0';

        -- Apply stimulus
        -- Example scenario: Select a product, insert coins, and check for change
        -- Feel free to modify this scenario according to your requirements

        -- Select product
        pin01 <= '1'; -- Example: Product 1 selected
        enter <= '1'; -- Example: Product 1
        wait for CLK_PERIOD * 1;
        pin01 <= '0';

        -- Insert coins
        pin04 <= '1'; -- Example: Insert coin 1
        wait for CLK_PERIOD * 1;
        pin04 <= '0';

        pin05 <= '1'; -- Example: Insert coin 2
        wait for CLK_PERIOD * 1;
        pin05 <= '0';

        -- Wait for change
        wait for CLK_PERIOD * 10;

        -- Reset
        pin09 <= '1';
        wait for CLK_PERIOD * 1;
        pin09 <= '0';

        -- Wait for completion

       -- wait;
    end process;

end tb_arch;
