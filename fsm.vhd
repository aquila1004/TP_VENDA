
-- vsg_off
library IEEE;
use IEEE.std_logic_1164.all;

entity dispenser1 is
    port (
        state: in std_logic;
        dispenserSignal: out std_logic
    );
end entity dispenser1;

architecture behavioral of dispenser1 is
begin
    process (state)
    begin
        if state = '1' then
            dispenserSignal <= '1';
        else
            dispenserSignal <= '0';
        end if;
    end process;
end architecture behavioral;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation1 is
    port (
        productPrice: in unsigned(7 downto 0);
        coinSum: in unsigned(7 downto 0);
        change: inout unsigned(7 downto 0);
        segmentA: out std_logic;
        segmentB: out std_logic;
        segmentC: out std_logic;
        segmentD: out std_logic;
        segmentE: out std_logic;
        segmentF: out std_logic;
        segmentG: out std_logic
    );
end entity change_calculation1;

architecture behavioral of change_calculation1 is
begin
    process (productPrice, coinSum)
    begin
        if coinSum >= productPrice then
            change <= coinSum - productPrice;
        else
            change <= (others => '0');
        end if;

        case change is
            when "00000000" =>
                segmentA <= '0';
                segmentB <= '1';
                segmentC <= '1';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
            when "00000001" =>
                segmentA <= '1';
                segmentB <= '1';
                segmentC <= '1';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
            when "00000010" =>
                segmentA <= '1';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00000011" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00000100" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00000101" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00000110" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00000111" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "00001000" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when others =>
                -- Valor do troco maior que 9, definir todos os segmentos como inválidos
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
        end case;
    end process;
end architecture behavioral;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador1 is
    generic (
        NUM_COINS : integer := 6
    );
    port (
        coinSum    : in  unsigned(NUM_COINS-1 downto 0);
        productPrice: in  unsigned(NUM_COINS-1 downto 0);
        dispense   : out std_logic
    );
end entity comparador1;

architecture behavioral of comparador1 is
begin
    process (coinSum, productPrice)
    begin
        if coinSum >= productPrice then
            dispense <= '1';
        else
            dispense <= '0';
        end if;
    end process;
end architecture behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor_clock1 is
port ( clk50MHz : in std_logic;
       reset : in std_logic;
       clk1Hz : out std_logic
     );
end divisor_clock1;

architecture Behavioral of divisor_clock1 is

--signal count : integer := 0;
signal b : std_logic := '0';
begin

 -- clk generation. For 50MHz clock this process generates 1Hz clock.
process(clk50MHz, b)
	variable cnt : integer range 0 to 2**26-1;
	begin
		if(rising_edge(clk50MHz)) then
		   if(reset = '1') then
			   cnt := 0;
			else
			   cnt := cnt + 1;
         end if;
			if(cnt = 24999999) then
				b <= not b;
				cnt := 0;
			end if;
		end if;
		clk1Hz <= b;
	end process;
end;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador1 is
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
end entity registrador1;

architecture behavioral of registrador1 is
    signal sum_reg: unsigned(DATA_WIDTH-1 downto 0);
    signal price_reg: unsigned(DATA_WIDTH-1 downto 0);
begin
    process (clock, reset)
    begin
        if reset = '1' then
            sum_reg <= (others => '0');
            price_reg <= (others => '0');
        elsif rising_edge(clock) then
            sum_reg <= sum_reg + coin;
            price_reg <= productPrice;
        end if;
    end process;

    sum <= sum_reg;
    price <= price_reg;
end architecture behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coin_insertion1 is
    port (
        pino4: in std_logic;
        pino5: in std_logic;
        pino6: in std_logic;
        pino7: in std_logic;
        coinSum: inout unsigned(7 downto 0)
    );
end entity coin_insertion1;

architecture behavioral of coin_insertion1 is
    signal coins: unsigned(7 downto 0) := (others => '0');
begin
    process (pino4, pino5, pino6, pino7)
    begin
        if (pino4 /= '0') then
            coins <= coins + 1;
        end if;
        
        if (pino5 /= '0') then
            coins <= coins + 2;
        end if;
        
        if (pino6 /= '0') then
            coins <= coins + 5;
        end if;
        
        if (pino7 /= '0') then
            coins <= coins + 10;
        end if;
        
        -- Atribuição correta do valor de coins a coinSum
        coinSum <= coins;
    end process;
end architecture behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity product_selection1 is
    port (
        pino1: in std_logic;
        pino2: in std_logic;
        pino3: in std_logic;
        produto_preco: out unsigned(7 downto 0)
    );
end entity product_selection1;

architecture rtl of product_selection1 is
begin
    process (pino1, pino2, pino3)
    begin
        if (pino1 = '0' and pino2 = '0' and pino3 = '0') then
            produto_preco <= to_unsigned(1, 8);  -- Produto 1
        elsif (pino1 = '0' and pino2 = '0' and pino3 = '1') then
            produto_preco <= to_unsigned(2, 8);  -- Produto 2
        elsif (pino1 = '0' and pino2 = '1' and pino3 = '0') then
            produto_preco <= to_unsigned(3, 8);  -- Produto 3
        elsif (pino1 = '0' and pino2 = '1' and pino3 = '1') then
            produto_preco <= to_unsigned(5, 8);  -- Produto 4
        elsif (pino1 = '1' and pino2 = '0' and pino3 = '0') then
            produto_preco <= to_unsigned(10, 8);  -- Produto 5
        elsif (pino1 = '1' and pino2 = '0' and pino3 = '1') then
            produto_preco <= to_unsigned(15, 8);  -- Produto 6
        else
            produto_preco <= (others => '0');
        end if;
    end process;
end architecture rtl;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fsm1 is 
    port (
        pin01: in std_logic;
        pin02: in std_logic;
        pin03: in std_logic;
        pin04: in std_logic;
        pin05: in std_logic;
        pin06: in std_logic;
        pin07: in std_logic;
        pin08: in std_logic; -- reset clock
        pin09: in std_logic; -- reset clock
        clk: in std_logic; -- clock
        change_display:  out std_logic;
        dispenser_display: out std_logic;
        segmento_display0: out std_logic;
        segmento_display1:out std_logic;
        segmento_display2: out std_logic;
        segmento_display3: out std_logic;
        segmento_display4: out std_logic;
        segmento_display5: out std_logic;
        segmento_display6:out std_logic
    );
end fsm1;

architecture arch_fsm of fsm1 is

    ---------------------------------
	-- COMPONENTE SELETOR PRODUTOS --
	---------------------------------

    component product_selection1 is
        port (
            pino1: in std_logic;
            pino2: in std_logic;
            pino3: in std_logic;
            produto_preco: out unsigned(7 downto 0)
        );
    end component product_selection1;

    -----------------------------------
	-- COMPONENTE INSERTOR DE MOEDAS --
	-----------------------------------

    component coin_insertion1 is
        port (
            pino4: in std_logic;
            pino5: in std_logic;
            pino6: in std_logic;
            pino7: in std_logic;
            coinSum: inout unsigned(7 downto 0)
        );
    end component coin_insertion1;

    ----------------------------    
	-- COMPONENTE REGISTRADOR --
	----------------------------
    
    component registrador1 is
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
    end component registrador1;

    ----------------------  
	-- COMPONENTE CLOCK --
	----------------------
    component divisor_clock1 is
        port ( clk50MHz : in std_logic;
               reset : in std_logic;
               clk1Hz : out std_logic
             );
    end component divisor_clock1;

    ---------------------------  
	-- COMPONENTE COMPARADOR --
	---------------------------
    component comparador1 is
        generic (
            NUM_COINS : integer := 8
        );
        port (
            coinSum    : in  unsigned(NUM_COINS-1 downto 0);
            productPrice: in  unsigned(NUM_COINS-1 downto 0);
            dispense   : out std_logic
        );
    end component comparador1;

    ----------------------  
	-- COMPONENTE TROCO --
	----------------------
    component change_calculation1 is
        port (
            productPrice: in unsigned(7 downto 0)	;
            coinSum: in unsigned(7 downto 0);
            change: inout unsigned(7 downto 0);
            segmentA: out std_logic;
            segmentB: out std_logic;
            segmentC: out std_logic;
            segmentD: out std_logic;
            segmentE: out std_logic;
            segmentF: out std_logic;
            segmentG: out std_logic
        );
    end component change_calculation1;

    --------------------------  
	-- COMPONENTE DISPENSER --
	--------------------------
    
    component dispenser1 is
        port(
            state: in std_logic;
            dispenserSignal: out std_logic
        );

    end component dispenser1;




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

    MeuClock: divisor_clock1 port map(
        clk50MHz => clk,
        reset => pin08,
        clk1Hz => saidaClock
    );

    SelectProduct: product_selection1 port map(
        pino1 => pin01,
        pino2 => pin02,
        pino3 => pin03,
        produto_preco => saidaProdutoSelecionado
    );

    InsertCoin: coin_insertion1 port map(
        pino4 => pin04,
        pino5 => pin05,
        pino6 => pin06,
        pino7 => pin07,
        coinSum => somaMoedas
    );

    MeuRegistrador: registrador1 port map(
        coin => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        clock => clk,
        reset => pin09,
        sum => somaRegistrador,
        price => precoRegistrador
    );

    VerificadorDeTroco: change_calculation1 port map(
        productPrice => saidaProdutoSelecionado,
        coinSum => somaMoedas,
        change => troco,
        segmentA => segmento_display0,
        segmentB => segmento_display1,
        segmentC => segmento_display2,
        segmentD => segmento_display3,
        segmentE => segmento_display4,
        segmentF => segmento_display5,
        segmentG => segmento_display6
    );

    MeuComparador: comparador1 port map(
        coinSum => somaMoedas,
        productPrice => saidaProdutoSelecionado,
        dispense => saidaComparador
    );

    MeuDispenser: dispenser1 port map(
        state => DispenserActive,
        dispenserSignal => dispenser_display
    );

    ------------------------------
	-- FIM PORT MAP COMPONENTES --
	------------------------------

    process(saidaClock)
        variable cnt : integer range 0 to 2**26-1;
        begin
            if(rising_edge(saidaClock)) then
                if(pin08 = '1') then
                    cnt := 0;
                else
                    cnt := cnt + 1;
                end if;
            end if;
        
        if(troco /= "0000000") then
            DispenserActive <= '1';
            if (cnt = 5) then
                DispenserActive <= '0';
                MeuReset <= '1';
            end if;
        end if;
        MeuReset <= '0';
    end process;

end arch_fsm;
