library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador_tb is
end entity registrador_tb;

architecture testbench of registrador_tb is
    constant DATA_WIDTH: natural := 8;

    signal coin_tb: unsigned(DATA_WIDTH-1 downto 0);
    signal productPrice_tb: unsigned(DATA_WIDTH-1 downto 0);
    signal clock_tb: std_logic := '0';
    signal reset_tb: std_logic := '0';
    signal sum_tb: unsigned(DATA_WIDTH-1 downto 0);
    signal price_tb: unsigned(DATA_WIDTH-1 downto 0);

    component registrador
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

begin
    dut: registrador
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            coin => coin_tb,
            productPrice => productPrice_tb,
            clock => clock_tb,
            reset => reset_tb,
            sum => sum_tb,
            price => price_tb
        );

    stimulus: process
    begin
        -- Valores iniciais
        coin_tb <= to_unsigned(5, DATA_WIDTH);
        productPrice_tb <= to_unsigned(10, DATA_WIDTH);
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';

        -- Aguarda um período de tempo
        wait for 20 ns;

        -- Exibe os valores armazenados
        report "Sum: " & integer'image(to_integer(sum_tb));
        report "Price: " & integer'image(to_integer(price_tb));

        -- Test case 1
        coin_tb <= to_unsigned(8, DATA_WIDTH);
        productPrice_tb <= to_unsigned(15, DATA_WIDTH);
        wait for 10 ns;
        report "Sum: " & integer'image(to_integer(sum_tb));
        report "Price: " & integer'image(to_integer(price_tb));

        -- Test case 2
        coin_tb <= to_unsigned(3, DATA_WIDTH);
        productPrice_tb <= to_unsigned(7, DATA_WIDTH);
        wait for 10 ns;
        report "Sum: " & integer'image(to_integer(sum_tb));
        report "Price: " & integer'image(to_integer(price_tb));

        wait;
    end process stimulus;
end architecture testbench;
