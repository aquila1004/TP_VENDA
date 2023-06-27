library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation is
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
        enable: in std_logic -- Sinal de enable adicionado
    );
end entity change_calculation;

architecture behavioral of change_calculation is
begin
    process (productPrice, coinSum, enable) -- Adicionado o sinal de enable ao processo
        variable var_change : unsigned(7 downto 0);
    begin
        if enable = '1' then -- Verifica se o enable está ativo
            if unsigned(coinSum) >= unsigned(productPrice) then
                var_change := coinSum - productPrice;
            else
                var_change := (others => '0');
            end if;
        else
            var_change := (others => '0');
        end if;

        -- A lógica abaixo foi realizada levando em consideração que o led acende no 0
        case var_change is 
            when "00000000" => -- Valor 0 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '1';

            when "00000001" => -- Valor 1 do troco
                segmentA <= '1';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
            
            when "00000010" => -- Valor 2 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '1';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '1';
                segmentG <= '0';

            when "00000011" => -- Valor 3 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '0';

            when "00000100" => -- Valor 4 do troco
                segmentA <= '1';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '0';
                segmentG <= '0';

            when "00000101" => -- Valor 5 do troco
                segmentA <= '0';
                segmentB <= '1';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '1';
                segmentF <= '0';
                segmentG <= '0';
            
            when "00000110" => -- Valor 6 do troco
                segmentA <= '0';
                segmentB <= '1';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            
            when "00000111" => -- Valor 7 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';

            when "00001000" => -- Valor 8 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            
            when "00001001" => -- Valor 9 do troco
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '1';
                segmentF <= '0';
                segmentG <= '0';
            
            when others => -- Em outros valores, não acende nenhum led
                segmentA <= '1';
                segmentB <= '1';
                segmentC <= '1';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
        end case;
          
        change <= var_change;
    end process;
end architecture behavioral;
