LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.numeric_std.ALL;

ENTITY datapath_tb IS
END datapath_tb;

ARCHITECTURE tb_arch OF datapath_tb IS

    -- Componente under test
    COMPONENT datapath
        PORT (
            moeda_1              : IN  STD_LOGIC; -- Valor 1 da moeda
            moeda_2              : IN  STD_LOGIC; -- Valor 2 da moeda
            moeda_3              : IN  STD_LOGIC; -- Valor 5 da moeda
            moeda_4              : IN  STD_LOGIC; -- Valor 10 da moeda
            pin01                : IN  STD_LOGIC; -- Seleção do produto
            pin02                : IN  STD_LOGIC; -- Seleção do produto
            pin03                : IN  STD_LOGIC; -- Seleção do produto
            clock01              : IN  STD_LOGIC;
            reset01              : IN  STD_LOGIC;
            pin_saida_comparador : OUT  STD_LOGIC; -- Saida do comparador
            pin_segmentA         : OUT  STD_LOGIC;
            pin_segmentB         : OUT  STD_LOGIC;
            pin_segmentC         : OUT  STD_LOGIC;
            pin_segmentD         : OUT  STD_LOGIC;
            pin_segmentE         : OUT  STD_LOGIC;
            pin_segmentF         : OUT  STD_LOGIC;
            pin_segmentG         : OUT  STD_LOGIC;
            pin_troco            : OUT  unsigned(7 DOWNTO 0)
        );
    END COMPONENT;

    -- Sinais de teste
    SIGNAL moeda_1_tb     : STD_LOGIC := '0';
    SIGNAL moeda_2_tb     : STD_LOGIC := '0';
    SIGNAL moeda_3_tb     : STD_LOGIC := '0';
    SIGNAL moeda_4_tb     : STD_LOGIC := '0';
    SIGNAL pin01_tb       : STD_LOGIC := '0';
    SIGNAL pin02_tb       : STD_LOGIC := '0';
    SIGNAL pin03_tb       : STD_LOGIC := '0';
    SIGNAL clock01_tb     : STD_LOGIC := '0';
    SIGNAL reset01_tb     : STD_LOGIC := '0';
    SIGNAL pin_saida_tb   : STD_LOGIC;
    SIGNAL pin_segmentA_tb: STD_LOGIC;
    SIGNAL pin_segmentB_tb: STD_LOGIC;
    SIGNAL pin_segmentC_tb: STD_LOGIC;
    SIGNAL pin_segmentD_tb: STD_LOGIC;
    SIGNAL pin_segmentE_tb: STD_LOGIC;
    SIGNAL pin_segmentF_tb: STD_LOGIC;
    SIGNAL pin_segmentG_tb: STD_LOGIC;
    SIGNAL pin_troco_tb   : unsigned(7 DOWNTO 0);

BEGIN

    -- Instância do datapath
    uut : datapath
        PORT MAP (
            moeda_1 => moeda_1_tb,
            moeda_2 => moeda_2_tb,
            moeda_3 => moeda_3_tb,
            moeda_4 => moeda_4_tb,
            pin01 => pin01_tb,
            pin02 => pin02_tb,
            pin03 => pin03_tb,
            clock01 => clock01_tb,
            reset01 => reset01_tb,
            pin_saida_comparador => pin_saida_tb,
            pin_segmentA => pin_segmentA_tb,
            pin_segmentB => pin_segmentB_tb,
            pin_segmentC => pin_segmentC_tb,
            pin_segmentD => pin_segmentD_tb,
            pin_segmentE => pin_segmentE_tb,
            pin_segmentF => pin_segmentF_tb,
            pin_segmentG => pin_segmentG_tb,
            pin_troco => pin_troco_tb
        );

    -- Estímulos de clock
    clock_process : process
    begin
        clock01_tb <= '0';
        wait for 10 ns;
        clock01_tb <= '1';
        moeda_1_tb <= '1';
        moeda_2_tb <= '0';
        moeda_3_tb <= '0';
        moeda_4_tb <= '1';
        pin01_tb <= '1';
        wait for 10 ns;
    end process;

    -- Estímulos de reset
    reset_process : process
    begin
        reset01_tb <= '1';
        wait for 20 ns;
        reset01_tb <= '0';
        wait;
    end process;

    -- Estímulos de entrada
    stimuli_process : process
    begin
        -- Configure os estímulos de entrada aqui
        -- Exemplo: moeda_1_tb <= '1'; para inserir a moeda de valor 1

        wait for 100 ns;

        -- Verifique os resultados aqui
        -- Exemplo: assert pin_segmentA_tb = '1' report "Erro: segment A incorreto" severity error;

        wait;
    end process;

END tb_arch;
