-- Multiplexador 2x1 de 3 bit.

library ieee;
use ieee.std_logic_1164.all;

entity mux2_1x3 is
port(state: in std_logic;
    clk_sel: in std_logic_vector(2 downto 0);
    ckproc_sel: out std_logic_vector(2 downto 0));
end mux2_1x3;

architecture arc of mux2_1x3 is
begin
ckproc_sel <= "001" when state = '0' else
		clk_sel;
end arc;