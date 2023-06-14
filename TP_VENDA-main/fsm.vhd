LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY fsm IS
    PORT (
        pin01 : IN STD_LOGIC;
        pin02 : IN STD_LOGIC;
        pin03 : IN STD_LOGIC;
        pin04 : IN STD_LOGIC;
        pin05 : IN STD_LOGIC;
        pin06 : IN STD_LOGIC;
        pin07 : IN STD_LOGIC;
        pin08 : IN STD_LOGIC; -- reset clock
        pin09 : IN STD_LOGIC; -- reset geral
        clk : IN STD_LOGIC; -- clock
        enter : IN STD_LOGIC; -- enter
        change_display : OUT STD_LOGIC;
        dispenser_display : OUT STD_LOGIC;
        segmento_display : out STD_LOGIC_VECTOR(0 TO 6);

        --Saida da fsm
        s : OUT STD_LOGIC
    );
END fsm;

ARCHITECTURE arch_fsm OF fsm IS

    TYPE state_type IS (INIT, SELECT1, LOAD, ADD, CHANGE, DIS);
    SIGNAL current_state, next_state : state_type;

    ---------------------------------
    -- COMPONENTE SELETOR PRODUTOS --
    ---------------------------------

    COMPONENT product_selection IS
        PORT (
            pino1 : IN STD_LOGIC;
            pino2 : IN STD_LOGIC;
            pino3 : IN STD_LOGIC;
            produto_preco : OUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT product_selection;

    -----------------------------------
    -- COMPONENTE INSERTOR DE MOEDAS --
    -----------------------------------

    COMPONENT coin_insertion IS
        PORT (
            pino4 : IN STD_LOGIC;
            pino5 : IN STD_LOGIC;
            pino6 : IN STD_LOGIC;
            pino7 : IN STD_LOGIC;
            coinSum : INOUT unsigned(7 DOWNTO 0)
        );
    END COMPONENT coin_insertion;

    ----------------------------    
    -- COMPONENTE REGISTRADOR --
    ----------------------------

    COMPONENT registrador IS
        GENERIC (
            DATA_WIDTH : NATURAL := 8
        );
        PORT (
            coin : IN unsigned(DATA_WIDTH - 1 DOWNTO 0);
            productPrice : IN unsigned(DATA_WIDTH - 1 DOWNTO 0);
            clock : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            sum : OUT unsigned(DATA_WIDTH - 1 DOWNTO 0);
            price : OUT unsigned(DATA_WIDTH - 1 DOWNTO 0)
        );
    END COMPONENT registrador;

    ----------------------  
    -- COMPONENTE CLOCK --
    ----------------------
    COMPONENT divisor_clock IS
        PORT (
            clk50MHz : IN STD_LOGIC;
            reset : IN STD_LOGIC;
            clk1Hz : OUT STD_LOGIC
        );
    END COMPONENT divisor_clock;

    ---------------------------  
    -- COMPONENTE COMPARADOR --
    ---------------------------
    COMPONENT comparador IS
        GENERIC (
            NUM_COINS : INTEGER := 8
        );
        PORT (
            coinSum : IN unsigned(NUM_COINS - 1 DOWNTO 0);
            productPrice : IN unsigned(NUM_COINS - 1 DOWNTO 0);
            dispense : OUT STD_LOGIC
        );
    END COMPONENT comparador;

    ----------------------  
    -- COMPONENTE TROCO --
    ----------------------
    COMPONENT change_calculation IS
        PORT (
            productPrice : IN unsigned(7 DOWNTO 0);
            coinSum : IN unsigned(7 DOWNTO 0);
            change : INOUT unsigned(7 DOWNTO 0);
            segment : OUT STD_LOGIC_VECTOR(0 TO 6)
        );
    END COMPONENT change_calculation;

    --------------------------  
    -- COMPONENTE DISPENSER --
    --------------------------

    COMPONENT dispenser IS
        PORT (
            state : IN STD_LOGIC;
            dispenserSignal : OUT STD_LOGIC
        );

    END COMPONENT dispenser;

    SIGNAL saidaProdutoSelecionado : unsigned(7 DOWNTO 0);
    SIGNAL precoProdutoSelecionado : unsigned(7 DOWNTO 0);
    SIGNAL somaMoedas : unsigned(7 DOWNTO 0);
    SIGNAL somaRegistrador : unsigned(7 DOWNTO 0);
    SIGNAL precoRegistrador : unsigned(7 DOWNTO 0);
    SIGNAL saidaClock : STD_LOGIC;
    SIGNAL saidaComparador : STD_LOGIC;
    SIGNAL troco : unsigned(7 DOWNTO 0);
    SIGNAL MeuReset : STD_LOGIC;
    SIGNAL DispenserActive : STD_LOGIC;

BEGIN

    --------------------------
    -- PORT MAP COMPONENTES --
    --------------------------

    MeuClock : divisor_clock PORT MAP(
        clk50MHz => clk,
        reset => pin08,
        clk1Hz => saidaClock
    );
    SelectProduct : product_selection PORT MAP(
        pino1 => pin01,
        pino2 => pin02,
        pino3 => pin03,
        produto_preco => saidaProdutoSelecionado
    );

    InsertCoin : coin_insertion PORT MAP(
        pino4 => pin04,
        pino5 => pin05,
        pino6 => pin06,
        pino7 => pin07,
        coinSum => somaMoedas
    );

    MeuRegistrador : registrador PORT MAP(
        coin => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        clock => clk,
        reset => pin09,
        sum => somaRegistrador,
        price => precoRegistrador
    );

    VerificadorDeTroco : change_calculation PORT MAP(
        productPrice => saidaProdutoSelecionado,
        coinSum => somaMoedas,
        change => troco,
        segment => segmento_display
    );

    MeuComparador : comparador PORT MAP(
        coinSum => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        dispense => saidaComparador
    );

    MeuDispenser : dispenser PORT MAP(
        state => DispenserActive,
        dispenserSignal => dispenser_display
    );

    ------------------------------
    -- FIM PORT MAP COMPONENTES --
    ------------------------------

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
        precoProdutoSelecionado <= "00000000";
        somaMoedas <= "00000000";
        somaRegistrador <= "00000000";
        precoRegistrador <= "00000000";
        troco <= "00000000";
        s <= '0';

        CASE current_state IS
            WHEN INIT =>
                dispenser_display <= '0';
                saidaProdutoSelecionado <= "00000000";
                precoProdutoSelecionado <= "00000000";
                somaMoedas <= "00000000";
                somaRegistrador <= "00000000";
                precoRegistrador <= "00000000";
                troco <= "00000000";
                next_state <= SELECT1;

            WHEN SELECT1 =>
                IF (pin01 = '0' AND pin02 = '0' AND pin03 = '0' and enter = '1') THEN
                    next_state <= LOAD;
                ELSIF (pin01 = '0' AND pin02 = '0' AND pin03 = '1' and enter = '1') THEN
                    next_state <= LOAD;
                ELSIF (pin01 = '0' AND pin02 = '1' AND pin03 = '0' and enter = '1') THEN
                    next_state <= LOAD;
                ELSIF (pin01 = '0' AND pin02 = '1' AND pin03 = '1' and enter = '1') THEN
                    next_state <= LOAD;
                ELSIF (pin01 = '1' AND pin02 = '0' AND pin03 = '0' and enter = '1') THEN
                    next_state <= LOAD;
                ELSIF (pin01 = '1' AND pin02 = '0' AND pin03 = '1' and enter = '1') THEN
                    next_state <= LOAD;
                    else 
                    next_state <= SELECT1;
					END IF;
                WHEN LOAD =>
                    IF (pin04 = '1' OR pin05 = '1' OR pin06 = '1' OR pin07 = '1') THEN -- Se alguma moeda for inserida, vai pro estado ADD
                        next_state <= ADD;

                    ELSIF (somaMoedas < precoRegistrador) THEN
                        next_state <= LOAD;

                    ELSIF (somaMoedas >= precoRegistrador) THEN
                        next_state <= CHANGE;
                    END IF;

                WHEN ADD => -- Nesse estado é somado o valor das moedas inseridas com o preço que está no registrador
                    IF (pin04 = '1') THEN
                        precoRegistrador <= precoRegistrador + "00000001"; -- Valor 1 da moeda

                    ELSIF (pin05 = '1') THEN
                        precoRegistrador <= precoRegistrador + "00000010"; -- Valor 2 da moeda

                    ELSIF (pin06 = '1') THEN
                        precoRegistrador <= precoRegistrador + "00000101"; -- Valor 5 da moeda

                    ELSIF (pin07 = '1') THEN
                        precoRegistrador <= precoRegistrador + "00001010"; -- Valor 10 da moeda

                        next_state <= LOAD;
                    END IF;

                WHEN CHANGE => -- Nesse estado é calculado o valor do troco
                    troco <= somaMoedas - precoRegistrador;
                    next_state <= DIS;

                WHEN DIS =>
                    s <= '1';
                    current_state <= INIT;
                END CASE;
        END PROCESS;
        PROCESS (saidaClock)
            VARIABLE cnt : INTEGER RANGE 0 TO 2 ** 26 - 1;
            VARIABLE teste : unsigned (7 DOWNTO 0) := "00000000";
        BEGIN
            IF (rising_edge(saidaClock)) THEN
                IF (pin08 = '1') THEN
                    cnt := 0;
                ELSE
                    cnt := cnt + 1;
                END IF;
            END IF;

            IF troco /= 'U' THEN
                DispenserActive <= '1';
                IF cnt = 5 THEN
                    DispenserActive <= '0';
                    MeuReset <= '1';
                END IF;
            END IF;
        END PROCESS;

    END arch_fsm;
