library ieee;
use ieee.std_logic_1164.all;

entity demux is
port(ent, sel: in std_logic;
    out0, out1: out std_logic
);
end demux;

architecture arc of demux is
begin

	out0 <= (ent and not sel);
	out1 <= (ent and sel);

end arc;
