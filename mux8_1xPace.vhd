-- Multiplexador 8x1 que seleciona o clock.

library ieee;
use ieee.std_logic_1164.all;

entity mux8_1xPace is
port(ckproc_sel: in std_logic_vector(2 downto 0);
     clk_0_25Hz,
     clk_0_5Hz,
     clk_0_75Hz,
     clk_1Hz,
     clk_1_25Hz,
     clk_1_5Hz,
     clk_1_2Hz: in std_logic;
    pace: out std_logic);
end mux8_1xPace;

architecture arc of mux8_1xPace is
begin
pace  <= clk_0_25Hz when ckproc_sel = "000" else
	  clk_0_5Hz when ckproc_sel = "001" else
	  clk_0_75Hz when ckproc_sel = "010" else
	  clk_1Hz when ckproc_sel = "011" else
	  clk_1_25Hz when ckproc_sel = "100" else
	  clk_1_5Hz when ckproc_sel = "101" else
	  clk_1_2Hz;
end arc;