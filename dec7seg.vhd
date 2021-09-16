library IEEE;
use IEEE.Std_Logic_1164.all;

entity dec7seg is
port (En:  in std_logic_vector(3 downto 0);
      Sa:  out std_logic_vector(6 downto 0));
end dec7seg;

architecture decodificador of dec7seg is
begin 
  Sa <= "1000000" when En = "0000" else
       "1111001" when En = "0001" else    
       "0100100" when En = "0010" else    
       "0110000" when En = "0011" else 
       "0011001" when En = "0100" else 
       "0010010" when En = "0101" else 
       "0000010" when En = "0110" else 
       "1111000" when En = "0111" else 
       "0000000" when En = "1000" else 
       "0011000" when En = "1001" else 
       "0001000" when En = "1010" else 
       "0000011" when En = "1011" else 
       "1000110" when En = "1100" else 
       "0100001" when En = "1101" else 
       "0000110" when En = "1110" else 
       "0001110";
end decodificador;