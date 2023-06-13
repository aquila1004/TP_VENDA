library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity datapath is
    generic (
        DATA_WIDTH: natural := 8
    );
    port (
        coin: in unsigned(DATA_WIDTH-1 downto 0);
        productPrice: in unsigned(DATA_WIDTH-1 downto 0);
        clock: in std_logic;
        reset: in std_logic;
        sum: out unsigned(DATA_WIDTH-1 downto 0);
        price: out unsigned(DATA_WIDTH-1 downto 0);
        change: out unsigned(DATA_WIDTH-1 downto 0);
        productSelection: in unsigned(DATA_WIDTH-1 downto 0)
    );
end entity datapath;

architecture behavioral of datapath is
    signal sum_reg: unsigned(DATA_WIDTH-1 downto 0);
    signal price_reg: unsigned(DATA_WIDTH-1 downto 0);
    signal change_reg: unsigned(DATA_WIDTH-1 downto 0);

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

    component coin_insertion
        generic (
            DATA_WIDTH: natural := 8
        );
        port (
            coin: in unsigned(DATA_WIDTH-1 downto 0);
            reset: in std_logic;
            valid: out std_logic
        );
    end component coin_insertion;

    component comparador
        generic (
            DATA_WIDTH: natural := 8
        );
        port (
            a: in unsigned(DATA_WIDTH-1 downto 0);
            b: in unsigned(DATA_WIDTH-1 downto 0);
            equal: out std_logic;
            lessThan: out std_logic;
            greaterThan: out std_logic
        );
    end component comparador;

    component change_calculation
        generic (
            DATA_WIDTH: natural := 8
        );
        port (
            sum: in unsigned(DATA_WIDTH-1 downto 0);
            price: in unsigned(DATA_WIDTH-1 downto 0);
            change: out unsigned(DATA_WIDTH-1 downto 0)
        );
    end component change_calculation;

    component product_selection
        generic (
            DATA_WIDTH: natural := 8
        );
        port (
            productSelection: in unsigned(DATA_WIDTH-1 downto 0);
            reset: in std_logic;
            valid: out std_logic
        );
    end component product_selection;

begin
    reg: registrador
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            coin => coin,
            productPrice => productPrice,
            clock => clock,
            reset => reset,
            sum => sum_reg,
            price => price_reg
        );

    insert: coin_insertion
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            coin => coin,
            reset => reset,
            valid => open
        );

    comp: comparador
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            a => sum_reg,
            b => price_reg,
            equal => open,
            lessThan => open,
            greaterThan => open
        );

    calc: change_calculation
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            sum => sum_reg,
            price => price_reg,
            change => change_reg
        );

    select1: product_selection
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            productSelection => productSelection,
            reset => reset,
            valid => open
        );

    sum <= sum_reg;
    price <= price_reg;
    change <= change_reg;

end architecture behavioral;
