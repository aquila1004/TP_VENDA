library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador is
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
end entity registrador;

architecture behavioral of registrador is
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