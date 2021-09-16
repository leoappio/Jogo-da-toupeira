library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_toupeira is 
port (CLK, E, R: in std_logic;
      TC7: out std_logic;
      TRIAL2_0: out std_logic_vector(2 downto 0));
end Counter_toupeira;

architecture count of Counter_toupeira is
signal cnt: std_logic_vector(2 downto 0) := "000";
begin
  process(CLK, R, E)
  begin
    if (R = '1') then
        cnt <= "000";
    elsif (CLK'event and CLK = '1' and E = '1') then
        cnt <= cnt + "001";
    end if;
  end process;
  
  TRIAL2_0 <= cnt;
  
  TC7 <= '1' when cnt = "111" else
          '0';
end count;