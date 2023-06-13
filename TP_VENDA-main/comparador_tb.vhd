library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador_tb is
end entity comparador_tb;

architecture testbench of comparador_tb is
    constant NUM_COINS : integer := 6;
    
    signal coinSum     : unsigned(NUM_COINS-1 downto 0);
    signal productPrice: unsigned(NUM_COINS-1 downto 0);
    signal dispense    : std_logic;

begin
    -- Instanciar o componente comparador
    uut: entity work.comparador
        generic map (
            NUM_COINS => NUM_COINS
        )
        port map (
            coinSum     => coinSum,
            productPrice => productPrice,
            dispense    => dispense
        );

    -- Estímulos de entrada
    stimulus: process
    begin
        -- Teste 1: coinSum < productPrice
        coinSum <= "000010";
        productPrice <= "000100";
        wait for 10 ns;
        
        -- Teste 2: coinSum = productPrice
        coinSum <= "000100";
        productPrice <= "000100";
        wait for 10 ns;
        
        -- Teste 3: coinSum > productPrice
        coinSum <= "001000";
        productPrice <= "000100";
        wait for 10 ns;
        
        -- Teste 4: coinSum = 0, productPrice = 0
        coinSum <= "000000";
        productPrice <= "000000";
        wait for 10 ns;
        
        -- Teste 5: coinSum = 0, productPrice > 0
        coinSum <= "000000";
        productPrice <= "000100";
        wait for 10 ns;
        
        -- Teste 6: coinSum > 0, productPrice = 0
        coinSum <= "000100";
        productPrice <= "000000";
        wait for 10 ns;
        
        -- Teste 7: coinSum > NUM_COINS, productPrice > 0
        coinSum <= "111111";
        productPrice <= "000100";
        wait for 10 ns;
        
        -- Teste 8: coinSum > 0, productPrice > NUM_COINS
        coinSum <= "000100";
        productPrice <= "111111";
        wait for 10 ns;
        
        -- Teste 9: coinSum > NUM_COINS, productPrice > NUM_COINS
        coinSum <= "111111";
        productPrice <= "111111";
        wait for 10 ns;
        
        -- Finalizar a simulação
        wait;
    end process;

    -- Monitorar os sinais de saída
    monitor: process (dispense)
    begin
        report "dispense = " & std_logic'image(dispense);
    end process;

end architecture testbench;
