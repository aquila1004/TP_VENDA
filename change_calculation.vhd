library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity change_calculation is
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
end entity change_calculation;

architecture behavioral of change_calculation is
begin
    process (productPrice, coinSum)
    begin
        if coinSum >= productPrice then
            change <= coinSum - productPrice;
        else
            change <= (others => '0');
        end if;

        case change is
            when "0000000" =>
                segmentA <= '0';
                segmentB <= '1';
                segmentC <= '1';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
            when "0000001" =>
                segmentA <= '1';
                segmentB <= '1';
                segmentC <= '1';
                segmentD <= '1';
                segmentE <= '1';
                segmentF <= '1';
                segmentG <= '1';
            when "0000010" =>
                segmentA <= '1';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0000011" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0000100" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0000101" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0000110" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0000111" =>
                segmentA <= '0';
                segmentB <= '0';
                segmentC <= '0';
                segmentD <= '0';
                segmentE <= '0';
                segmentF <= '0';
                segmentG <= '0';
            when "0001000" =>
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
