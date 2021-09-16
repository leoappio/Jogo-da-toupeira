library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
entity Counter_nivel is 
port (CLK: in std_logic;
      E: in std_logic;
      nivel: out std_logic_vector(1 downto 0) );
end Counter_nivel;

architecture count of Counter_nivel is
signal cnt: std_logic_vector(1 downto 0) := "00";
begin
  process(CLK)
  begin
    if (CLK'event and CLK = '1') then
        if E = '1' then
            cnt <= cnt + "01";
        end if;
    end if;
  end process;
  nivel <= cnt;
end count;
