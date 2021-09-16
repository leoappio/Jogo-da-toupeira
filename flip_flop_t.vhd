library ieee;
use ieee.std_logic_1164.all;
entity flip_flop_t is port (
	CLK: in std_logic;
	E: in std_logic;
	Q: out std_logic );
end flip_flop_t;

architecture behv of flip_flop_t is
signal s: std_logic := '0';
begin
	process(CLK, E)
	begin
		if (CLK'event and CLK = '1' and E = '1') then
		    s <= not(s);
		else s <= s;
		end if;
	end process;
	Q <= s;
end behv;
