library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm is 
    port (
        pin01: in std_logic;
        pin02: in std_logic;
        pin03: in std_logic;
        pin04: in std_logic;
        pin05: in std_logic;
        pin06: in std_logic;
        pin07: in std_logic;
        pin08: in std_logic; -- reset clock
        pin09: in std_logic; -- reset geral
        clk: in std_logic; -- clock
        change_display:  out std_logic;
        dispenser_display: out std_logic;
        segmento_display : std_logic_vector(0 to 6);

        --Saida da fsm
        s : out std_logic
    );
end fsm;

architecture arch_fsm of fsm is

    type state_type is (INIT, LOAD, ADD, CHANGE, DIS);
    signal current_state, next_state : state_type;

    ---------------------------------
  -- COMPONENTE SELETOR PRODUTOS --
  ---------------------------------

    component product_selection is
        port (
            pino1: in std_logic;
            pino2: in std_logic;
            pino3: in std_logic;
            produto_preco: out unsigned(7 downto 0)
        );
    end component product_selection;

    -----------------------------------
  -- COMPONENTE INSERTOR DE MOEDAS --
  -----------------------------------

    component coin_insertion is
        port (
            pino4: in std_logic;
            pino5: in std_logic;
            pino6: in std_logic;
            pino7: in std_logic;
            coinSum: inout unsigned(7 downto 0)
        );
    end component coin_insertion;

    ----------------------------    
  -- COMPONENTE REGISTRADOR --
  ----------------------------
    
    component registrador is
        generic (
            DATA_WIDTH: natural := 8
        );
        port (
            coin: in unsigned(DATA_WIDTH-1 downto 0);
            productPrice: in unsigned(DATA_WIDTH-1 downto 0);
            clock: in std_logic;
            reset: in std_logic;
            sum: out unsigned(DATA_WIDTH-1 downto 0);
            price: out unsigned(DATA_WIDTH-1 downto 0)
        );
    end component registrador;

    ----------------------  
  -- COMPONENTE CLOCK --
  ----------------------
    component divisor_clock is
        port ( clk50MHz : in std_logic;
               reset : in std_logic;
               clk1Hz : out std_logic
             );
    end component divisor_clock;

    ---------------------------  
  -- COMPONENTE COMPARADOR --
  ---------------------------
    component comparador is
        generic (
            NUM_COINS : integer := 8
        );
        port (
            coinSum    : in  unsigned(NUM_COINS-1 downto 0);
            productPrice: in  unsigned(NUM_COINS-1 downto 0);
            dispense   : out std_logic
        );
    end component comparador;

    ----------------------  
  -- COMPONENTE TROCO --
  ----------------------
    component change_calculation is
        port (
            productPrice: in unsigned(7 downto 0)  ;
            coinSum: in unsigned(7 downto 0);
            change: inout unsigned(7 downto 0);
            segment : out std_logic_vector(0 to 6)
        );
    end component change_calculation;

    --------------------------  
  -- COMPONENTE DISPENSER --
  --------------------------
    
    component dispenser is
        port(
            state: in std_logic;
            dispenserSignal: out std_logic
        );

    end component dispenser;

    signal saidaProdutoSelecionado : unsigned(7 downto 0); 
    signal precoProdutoSelecionado : unsigned(7 downto 0);
    signal somaMoedas : unsigned(7 downto 0);
    signal somaRegistrador : unsigned(7 downto 0);
    signal precoRegistrador : unsigned(7 downto 0);
    signal saidaClock : std_logic;
    signal saidaComparador : std_logic;
    signal troco : unsigned(7 downto 0);
    signal MeuReset : std_logic;
    signal DispenserActive : std_logic;

begin

    --------------------------
  -- PORT MAP COMPONENTES --
  --------------------------

    MeuClock: divisor_clock port map(
        clk50MHz => clk,
        reset => pin08,
        clk1Hz => saidaClock
    );
SelectProduct: product_selection port map(
        pino1 => pin01,
        pino2 => pin02,
        pino3 => pin03,
        produto_preco => saidaProdutoSelecionado
    );

    InsertCoin: coin_insertion port map(
        pino4 => pin04,
        pino5 => pin05,
        pino6 => pin06,
        pino7 => pin07,
        coinSum => somaMoedas
    );

    MeuRegistrador: registrador port map(
        coin => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        clock => clk,
        reset => pin09,
        sum => somaRegistrador,
        price => precoRegistrador
    );

    VerificadorDeTroco: change_calculation port map(
        productPrice => saidaProdutoSelecionado,
        coinSum => somaMoedas,
        change => troco,
        segment => segmento_display  
    );

    MeuComparador: comparador port map(
        coinSum => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        dispense => saidaComparador
    );

    MeuDispenser: dispenser port map(
        state => DispenserActive,
        dispenserSignal => dispenser_display
    );

    ------------------------------
  -- FIM PORT MAP COMPONENTES --
  ------------------------------

    processo_sequencial: process(clk, pin09)
    begin
        if(pin09 = '1') then
            current_state <= INIT;

        elsif(rising_edge(clk)) then
            current_state <= next_state;
        end if;
    end process;

    processo_combinacional: process(current_state)
    begin
        saidaProdutoSelecionado <= "00000000";
        precoProdutoSelecionado <= "00000000";
        somaMoedas              <= "00000000";
        somaRegistrador         <= "00000000";
        precoRegistrador        <= "00000000";
        troco                   <= "00000000";
        s                       <= '0';
        
        case current_state is
            when INIT =>
                
                dispenser_display <= '0';
                next_state <= LOAD;
            
            when LOAD =>
                if(pin04 = '1' or pin05 = '1' or pin06 = '1' or pin07 = '1') then -- Se alguma moeda for inserida, vai pro estado ADD
                    next_state <= ADD;

                elsif(somaMoedas < precoRegistrador) then
                    next_state <= LOAD;
                
                elsif(somaMoedas >= precoRegistrador) then
                    next_state <= CHANGE;
                end if;
            
            when ADD => -- Nesse estado é somado o valor das moedas inseridas com o preço que está no registrador
                if(pin04 = '1') then
                    precoRegistrador <= precoRegistrador + "00000001"; -- Valor 1 da moeda
                
                elsif(pin05 = '1') then
                    precoRegistrador <= precoRegistrador + "00000010"; -- Valor 2 da moeda
                
                elsif(pin06 = '1') then
                    precoRegistrador <= precoRegistrador + "00000101"; -- Valor 5 da moeda
                
                elsif(pin07 = '1') then
                    precoRegistrador <= precoRegistrador + "00001010"; -- Valor 10 da moeda
                
                next_state <= LOAD;
                end if;
            
            when CHANGE => -- Nesse estado é calculado o valor do troco
                troco <= somaMoedas - precoRegistrador;
                next_state <= DIS;
            
            when DIS =>
                    s <= '1';
                    current_state <= INIT;
            end case;
        end process;
process(saidaClock)
        variable cnt : integer range 0 to 2**26-1;
        variable teste : unsigned (7 downto 0) := "00000000";
        begin
            if(rising_edge(saidaClock)) then
                if(pin08 = '1') then
                    cnt := 0;
                else
                    cnt := cnt + 1;
                end if;
            end if;
        
        if(troco /= teste) then
            DispenserActive <= '1';
            if (cnt = 5) then
                DispenserActive <= '0';
                MeuReset <= '1';
            end if;
        end if;
        MeuReset <= '0';
    end process;

end arch_fsm;