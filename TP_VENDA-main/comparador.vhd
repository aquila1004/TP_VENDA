library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity comparador is
    generic (
        NUM_COINS : integer := 8
    );
    port (
        coinSum    : in  unsigned(NUM_COINS-1 downto 0);
        productPrice: in  unsigned(NUM_COINS-1 downto 0);
        dispense   : out std_logic
    );
end entity comparador;

architecture behavioral of comparador is
begin
    process (coinSum, productPrice)
    begin
        if unsigned(coinSum) >= unsigned(productPrice) then
            dispense <= '1';
        else
            dispense <= '0';
        end if;
    end process;
end architecture behavioral;

