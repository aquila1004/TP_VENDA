library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity coin_insertion_tb is
end entity coin_insertion_tb;

architecture tb_arch of coin_insertion_tb is
    component coin_insertion is
        port (
            pino4: in std_logic;
            pino5: in std_logic;
            pino6: in std_logic;
            pino7: in std_logic;
            enable: in std_logic;
            coinSum: inout unsigned(7 downto 0)
        );
    end component coin_insertion;

    signal pino4_tb, pino5_tb, pino6_tb, pino7_tb, enable_tb: std_logic;
    signal coinSum_tb: unsigned(7 downto 0);

begin
    uut: coin_insertion
        port map (
            pino4 => pino4_tb,
            pino5 => pino5_tb,
            pino6 => pino6_tb,
            pino7 => pino7_tb,
            enable => enable_tb,
            coinSum => coinSum_tb
        );

    stimulus: process
    begin
        -- Teste 1 (enable ativo)
        pino4_tb <= '1';
        pino5_tb <= '1';
        pino6_tb <= '0';
        pino7_tb <= '0';
        enable_tb <= '1';
        wait for 10 ns;
        
        -- Verifica o valor de coinSum_tb
        assert coinSum_tb = to_unsigned(3, 8) report "Erro: Valor incorreto de coinSum_tb no Teste 1" severity error;
        
        -- Teste 2 (enable inativo)
        pino4_tb <= '0';
        pino5_tb <= '0';
        pino6_tb <= '1';
        pino7_tb <= '0';
        enable_tb <= '0';
        wait for 10 ns;
        
        -- Verifica o valor de coinSum_tb
        assert coinSum_tb = to_unsigned(0, 8) report "Erro: Valor incorreto de coinSum_tb no Teste 2" severity error;
        
        -- Adicione mais testes conforme necessário

        wait;
    end process;
end architecture tb_arch;
