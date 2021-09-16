-- Multiplexador 4x1 de 8 bits.

library ieee;
use ieee.std_logic_1164.all;

entity mux4_1x8 is
port(seq: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(7 downto 0);
    toup: out std_logic_vector(7 downto 0));
end mux4_1x8;

architecture arc of mux4_1x8 is
begin
toup <= ent0 when seq = "00" else
	  ent1 when seq = "01" else
	  ent2 when seq = "10" else
	  ent3;
end arc;
