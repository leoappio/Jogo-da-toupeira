library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_unsigned.all;

entity Counter_trial is 
port (CLK, E, R: in std_logic;
      TCN3: out std_logic;
      TRIAL4_3: out std_logic_vector(1 downto 0));
end Counter_trial;

architecture count of Counter_trial is
signal cnt: std_logic_vector(1 downto 0) := "00";
begin
  process(CLK, R, E, cnt)
  begin
    if (R = '1') then
        cnt <= "00";
    elsif (CLK'event and CLK = '1') then
        if E = '1' then
            cnt <= cnt + "01";
        end if;
    end if;
  end process;
  
  TCN3 <= '0' when cnt = "11" else
          '1';
   
  TRIAL4_3 <= cnt;
end count;