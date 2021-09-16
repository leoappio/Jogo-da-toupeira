library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;
entity Counter_score is 
port (CLK, E, R: in std_logic;
      data: in std_logic_vector(1 downto 0);
      score: out std_logic_vector(7 downto 0) );
end Counter_score;

architecture count of Counter_score is
signal cnt: std_logic_vector(7 downto 0) := "00000000";
begin
  process(CLK, R)
  begin
    if (R = '1') then
        cnt <= "00000000";
    elsif (CLK'event and CLK = '1') then
        if E = '1' then
            cnt <= cnt + data + "00000001";
        end if;
    end if;
  end process;
  score <= cnt;
end count;