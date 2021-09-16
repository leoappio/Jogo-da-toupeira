-- Multiplexador 4x1 de 7 bit.

library ieee;
use ieee.std_logic_1164.all;

entity mux4_1x7 is
port(
	sel: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(6 downto 0);
    ss: out std_logic_vector(6 downto 0)
);
end mux4_1x7;

architecture arc of mux4_1x7 is
begin
ss <= ent0 when sel = "00" else
	  ent1 when sel = "01" else
	  ent2 when sel = "10" else
	  ent3;
end arc;