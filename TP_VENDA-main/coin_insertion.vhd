library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coin_insertion is
    port (
        pino4 : in std_logic;
        pino5 : in std_logic;
        pino6 : in std_logic;
        pino7 : in std_logic;
        enable : in std_logic; -- Sinal de enable adicionado
        coinSum : inout unsigned(7 downto 0)
    );
end entity coin_insertion;

architecture behavioral of coin_insertion is
   -- variable coins : unsigned(7 downto 0) := (others => '0');
begin
    process (pino4, pino5, pino6, pino7, enable) -- Adicionado o sinal de enable ao processo
    variable coins : unsigned(7 downto 0):= (others => '0') ;
    begin
        --coins := (others => '0'); -- Zera o valor de coins inicialmente
        if enable = '1' then -- Verifica se o enable está ativo
            if (pino4 = '1' and pino5 = '0' and pino6 = '0' and pino7 = '0') then
                coins := coins + 1;
            elsif (pino4 = '1' and pino5 = '1' and pino6 = '0' and pino7 = '0') then
                coins := coins + 3;
            elsif (pino4 = '1' and pino6 = '1' and pino5 = '0' and pino7 = '0') then
                coins := coins + 6;
            elsif (pino4 = '1' and pino7 = '1' and pino5 = '0' and pino6 = '0') then
                coins := coins + 11;
            elsif (pino4 = '1' and pino5 = '1' and pino6 = '1' and pino7 = '0') then
                coins := coins + 8;
            elsif (pino4 = '1' and pino5 = '1' and pino7 = '1' and pino6 = '0') then
                coins := coins + 13;
            elsif (pino4 = '1' and pino6 = '1' and pino7 = '1' and pino5 = '0') then
                coins := coins + 16;
            elsif (pino4 = '1' and pino5 = '1' and pino6 = '1' and pino7 = '1') then
                coins := coins + 18;
            elsif (pino5 = '1' and pino4 = '0' and pino6 = '0' and pino7 = '0') then
                coins := coins + 2;
            elsif (pino6 = '1' and pino5 = '0' and pino4 = '0' and pino7 = '0') then
                coins := coins + 5;
            elsif (pino7 = '1' and pino6 = '0' and pino5 = '0' and pino4 = '0') then
                coins := coins + 10;
            end if;
        end if;
        -- Atribuição correta do valor de coins a coinSum
        coinSum <= coins;
    end process;
end architecture behavioral;
