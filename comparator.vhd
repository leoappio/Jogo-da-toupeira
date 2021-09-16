-- Comparador da posição da toupeira e do valor das chaves 

library ieee;
use ieee.std_logic_1164.all;

entity comparator is
port(chaves, toupeira: in std_logic_vector(7 downto 0);
    saida: out std_logic);
end comparator;

architecture arc of comparator is
begin
saida <= '1' when chaves = toupeira else
		'0';
end arc;
