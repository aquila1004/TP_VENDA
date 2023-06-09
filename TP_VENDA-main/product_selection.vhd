library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity product_selection is
    port (
        pino1: in std_logic;
        pino2: in std_logic;
        pino3: in std_logic;
        enable: in std_logic; -- Adicionado o sinal de enable
        produto_preco: out unsigned(7 downto 0)
    );
end entity product_selection;

architecture rtl of product_selection is
begin
    process (pino1, pino2, pino3, enable) -- Adicionado o sinal de enable ao processo
    begin
        if enable = '1' then -- Verifica se o enable está ativo
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
        else
            produto_preco <= (others => '0'); -- Se o enable estiver inativo, o produto_preco é definido como 0
        end if;
    end process;
end architecture rtl;
