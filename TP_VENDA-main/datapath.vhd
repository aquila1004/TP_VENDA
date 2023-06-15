LIBRARY ieee;
USE ieee.std_logic_1164.all; 
USE IEEE.numeric_std.ALL;

LIBRARY work;

ENTITY datapath IS 
	PORT
	(
        moeda_1              :  IN  STD_LOGIC; -- Valor 1 da moeda
		moeda_2              :  IN  STD_LOGIC; -- Valor 2 da moeda
        moeda_3              :  IN  STD_LOGIC; -- Valor 5 da moeda
		moeda_4              :  IN  STD_LOGIC; -- Valor 10 da moeda
		pin01                :  IN  STD_LOGIC; -- Seleção do produto
		pin02                :  IN  STD_LOGIC; -- Seleção do produto
		pin03                :  IN  STD_LOGIC; -- Seleção do produto
		clock01              :  IN  STD_LOGIC;
		reset01              :  IN  STD_LOGIC;
		pin_saida_comparador :  OUT  STD_LOGIC; -- Saida do comparador
		pin_segmentA         :  OUT  STD_LOGIC;
		pin_segmentB         :  OUT  STD_LOGIC;
		pin_segmentC         :  OUT  STD_LOGIC;
		pin_segmentD         :  OUT  STD_LOGIC;
		pin_segmentE         :  OUT  STD_LOGIC;
		pin_segmentF         :  OUT  STD_LOGIC;
		pin_segmentG         :  OUT  STD_LOGIC;
		pin_troco            :  INOUT  unsigned(7 DOWNTO 0)
	);
END datapath;

ARCHITECTURE bdf_type OF datapath IS 

COMPONENT registrador
GENERIC (DATA_WIDTH : INTEGER
			);
	PORT(clock : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 coin : IN unsigned(7 DOWNTO 0);
		 productPrice : IN unsigned(7 DOWNTO 0);
		 price : OUT unsigned(7 DOWNTO 0);
		 sum : OUT unsigned(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT change_calculation
	PORT(change : INOUT unsigned(7 DOWNTO 0);
		 coinSum : IN unsigned(7 DOWNTO 0);
		 productPrice : IN unsigned(7 DOWNTO 0);
		 segmentA : OUT STD_LOGIC;
		 segmentB : OUT STD_LOGIC;
		 segmentC : OUT STD_LOGIC;
		 segmentD : OUT STD_LOGIC;
		 segmentE : OUT STD_LOGIC;
		 segmentF : OUT STD_LOGIC;
		 segmentG : OUT STD_LOGIC
	);
END COMPONENT;

COMPONENT coin_insertion
	PORT(pino4 : IN STD_LOGIC;
		 pino5 : IN STD_LOGIC;
		 pino6 : IN STD_LOGIC;
		 pino7 : IN STD_LOGIC;
		 coinSum : INOUT unsigned(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT product_selection
	PORT(pino1 : IN STD_LOGIC;
		 pino2 : IN STD_LOGIC;
		 pino3 : IN STD_LOGIC;
		 produto_preco : OUT unsigned(7 DOWNTO 0)
	);
END COMPONENT;

COMPONENT comparador
GENERIC (NUM_COINS : INTEGER
			);
	PORT(coinSum : IN unsigned(7 DOWNTO 0);
		 productPrice : IN unsigned(7 DOWNTO 0);
		 dispense : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  unsigned(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_1 :  unsigned(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_6 :  unsigned(7 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_7 :  unsigned(7 DOWNTO 0);

BEGIN 


b2v_inst : registrador
GENERIC MAP(DATA_WIDTH => 8
			)
PORT MAP(clock => clock01,
		 reset => reset01,
		 coin => SYNTHESIZED_WIRE_0,
		 productPrice => SYNTHESIZED_WIRE_1,
		 price => SYNTHESIZED_WIRE_7,
		 sum => SYNTHESIZED_WIRE_6);


b2v_inst2 : change_calculation
PORT MAP(change => pin_troco,
		 coinSum => SYNTHESIZED_WIRE_6,
		 productPrice => SYNTHESIZED_WIRE_7,
		 segmentA => pin_segmentA,
		 segmentB => pin_segmentB,
		 segmentC => pin_segmentC,
		 segmentD => pin_segmentD,
		 segmentE => pin_segmentE,
		 segmentF => pin_segmentF,
		 segmentG => pin_segmentG);


b2v_inst4 : coin_insertion
PORT MAP(pino4 => moeda_1,
		 pino5 => moeda_2,
		 pino6 => moeda_3,
		 pino7 => moeda_4,
		 coinSum => SYNTHESIZED_WIRE_0);


b2v_inst5 : product_selection
PORT MAP(pino1 => pin01,
		 pino2 => pin02,
		 pino3 => pin03,
		 produto_preco => SYNTHESIZED_WIRE_1);


b2v_inst7 : comparador
GENERIC MAP(NUM_COINS => 8
			)
PORT MAP(coinSum => SYNTHESIZED_WIRE_6,
		 productPrice => SYNTHESIZED_WIRE_7,
		 dispense => pin_saida_comparador);


END bdf_type;