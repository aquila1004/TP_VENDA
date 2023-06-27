LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm IS
    PORT (
        pin01             : IN STD_LOGIC; -- Escolher produto
        pin02             : IN STD_LOGIC; -- Escolher produto
        pin03             : IN STD_LOGIC; -- Escolher produto
        pin04             : IN STD_LOGIC; -- Insere moeda de valor 1
        pin05             : IN STD_LOGIC; -- Insere moeda de valor 2
        pin06             : IN STD_LOGIC; -- Insere moeda de valor 5
        pin07             : IN STD_LOGIC; -- Insere moeda de valor 10
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

        troco             : OUT unsigned(7 DOWNTO 0);

        --Saida da fsm
        s : OUT STD_LOGIC
    );
END fsm;

ARCHITECTURE arch_fsm OF fsm IS

    TYPE state_type IS (INIT, SELECT1, LOAD, ADD, CHANGE, DIS);
    SIGNAL current_state, next_state : state_type;

    component datapath
    port (
        moeda_1              :  IN  STD_LOGIC; -- Valor 1 da moeda
		moeda_2              :  IN  STD_LOGIC; -- Valor 2 da moeda
        moeda_3              :  IN  STD_LOGIC; -- Valor 5 da moeda
		moeda_4              :  IN  STD_LOGIC; -- Valor 10 da moeda
		pin01                :  IN  STD_LOGIC; -- Seleção do produto
		pin02                :  IN  STD_LOGIC; -- Seleção do produto
		pin03                :  IN  STD_LOGIC; -- Seleção do produto
		clock01              :  IN  STD_LOGIC;
		reset01              :  IN  STD_LOGIC;
		pin_saida_comparador :  OUT  STD_LOGIC; -- Saida do comparador
		pin_segmentA         :  OUT  STD_LOGIC;
		pin_segmentB         :  OUT  STD_LOGIC;
		pin_segmentC         :  OUT  STD_LOGIC;
		pin_segmentD         :  OUT  STD_LOGIC;
		pin_segmentE         :  OUT  STD_LOGIC;
		pin_segmentF         :  OUT  STD_LOGIC;
		pin_segmentG         :  OUT  STD_LOGIC;
		pin_troco            :  OUT  unsigned(7 DOWNTO 0)
    );
    end component;

    SIGNAL saidaProdutoSelecionado : unsigned(7 DOWNTO 0);
    SIGNAL precoProdutoSelecionado : unsigned(7 DOWNTO 0);
    SIGNAL somaMoedas              : unsigned(7 DOWNTO 0);
    SIGNAL somaRegistrador         : unsigned(7 DOWNTO 0);
    SIGNAL precoRegistrador        : unsigned(7 DOWNTO 0);
    SIGNAL saidaClock              : STD_LOGIC;
    SIGNAL saidaComparador         : STD_LOGIC;
	SIGNAL troco_rst					  : STD_LOGIC;

BEGIN

    datapath_ints : datapath
    port map (
        moeda_1              => pin04,
        moeda_2              => pin05,
        moeda_3              => pin06,
        moeda_4              => pin07,
        pin01                => pin01,
        pin02                => pin02,
        pin03                => pin03,
        clock01              => clk,
        reset01              => pin09,
        pin_saida_comparador => saidaComparador,
        pin_segmentA         => segment_displayA,
        pin_segmentB         => segment_displayB,
        pin_segmentC         => segment_displayC,
        pin_segmentD         => segment_displayD,
        pin_segmentE         => segment_displayE,
        pin_segmentF         => segment_displayF,
        pin_segmentG         => segment_displayG,
		  --pin_troco_rst		  => troco_rst,
        pin_troco            => troco
    );
    

    processo_sequencial : PROCESS (clk, pin09)
    BEGIN
        IF (pin09 = '1') THEN
            current_state <= INIT;

        ELSIF (rising_edge(clk)) THEN
            current_state <= next_state;
        END IF;
    END PROCESS;

    processo_combinacional : PROCESS (current_state)
    BEGIN
        CASE current_state IS
            WHEN INIT =>
                dispenser_display       <= '0';
					 --troco_rst < '1';
                saidaProdutoSelecionado <= "00000000";
                precoProdutoSelecionado <= "00000000";
                somaMoedas              <= "00000000";
                somaRegistrador         <= "00000000";
                precoRegistrador        <= "00000000";
                next_state <= SELECT1;

            WHEN SELECT1 =>
                    next_state <= SELECT1;
                WHEN LOAD =>
                    next_state <= LOAD;
                WHEN ADD => 
                    next_state <= LOAD;
                WHEN CHANGE => 
                    next_state <= DIS;

                WHEN DIS =>
                    next_state <= INIT;
                END CASE;
        END PROCESS;
END arch_fsm;
