-- Multiplexador 2x1 de 8 bit.

library ieee;
use ieee.std_logic_1164.all;

entity mux2_1x8 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(7 downto 0);
    saida: out std_logic_vector(7 downto 0));
end mux2_1x8;

architecture arc of mux2_1x8 is
begin
saida <= ent0 when sel = '0' else
		ent1;
end arc;
