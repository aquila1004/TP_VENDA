-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 13.6.2023 12:33:30 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_fsm is
end tb_fsm;

architecture tb of tb_fsm is

    component fsm
        port (pin01             : in std_logic;
              pin02             : in std_logic;
              pin03             : in std_logic;
              pin04             : in std_logic;
              pin05             : in std_logic;
              pin06             : in std_logic;
              pin07             : in std_logic;
              pin08             : in std_logic;
              pin09             : in std_logic;
              clk               : in std_logic;
              change_display    : out std_logic;
              dispenser_display : out std_logic;
              segmento_display0 : out std_logic;
              segmento_display1 : out std_logic;
              segmento_display2 : out std_logic;
              segmento_display3 : out std_logic;
              segmento_display4 : out std_logic;
              segmento_display5 : out std_logic;
              segmento_display6 : out std_logic);
    end component;

    signal pin01             : std_logic;
    signal pin02             : std_logic;
    signal pin03             : std_logic;
    signal pin04             : std_logic;
    signal pin05             : std_logic;
    signal pin06             : std_logic;
    signal pin07             : std_logic;
    signal pin08             : std_logic;
    signal pin09             : std_logic;
    signal clk               : std_logic;
    signal change_display    : std_logic;
    signal dispenser_display : std_logic;
    signal segmento_display0 : std_logic;
    signal segmento_display1 : std_logic;
    signal segmento_display2 : std_logic;
    signal segmento_display3 : std_logic;
    signal segmento_display4 : std_logic;
    signal segmento_display5 : std_logic;
    signal segmento_display6 : std_logic;

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : fsm
    port map (pin01             => pin01,
              pin02             => pin02,
              pin03             => pin03,
              pin04             => pin04,
              pin05             => pin05,
              pin06             => pin06,
              pin07             => pin07,
              pin08             => pin08,
              pin09             => pin09,
              clk               => clk,
              change_display    => change_display,
              dispenser_display => dispenser_display,
              segmento_display0 => segmento_display0,
              segmento_display1 => segmento_display1,
              segmento_display2 => segmento_display2,
              segmento_display3 => segmento_display3,
              segmento_display4 => segmento_display4,
              segmento_display5 => segmento_display5,
              segmento_display6 => segmento_display6);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        pin01 <= '1'; -- pin01, pin02, pin03 servem para escolher um produto
        pin02 <= '0';
        pin03 <= '0';
        pin04 <= '0'; -- pin04 seta o valor do produto como 1
        pin05 <= '0'; -- pin05 seta o valor do produto como 2
        pin06 <= '0'; -- pin06 seta o valor do produto como 5
        pin07 <= '1'; -- pin07 seta o valor do produto como 10
        pin08 <= '0'; -- pin08 e pin09 servem para o reset e para o reset do clock
        pin09 <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
       -- YOURRESETSIGNAL <= '1';
        wait for 100 ns;
        --YOURRESETSIGNAL <= '0';
        wait for 100 ns;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_fsm of tb_fsm is
    for tb
    end for;
end cfg_tb_fsm;