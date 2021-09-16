library ieee;
use ieee.std_logic_1164.all;

entity logica_trial is
port(N, T: in std_logic_vector(1 downto 0); 
     clk_sel: out std_logic_vector(2 downto 0));
end logica_trial;

architecture rtl of logica_trial is
signal A, B, C, D, E, F, G, H, I: std_logic;
begin

A <= N(1) and T(1);
B <= N(0) and T(1) and T(0);
C <= N(1) and N(0) and T(0);
D <= N(1) and not(T(1)) and not(T(0));
E <= N(1) and not(N(0)) and not(T(1));
F <= not(N(1)) and not(N(0)) and T(1);
G <= not(N(1)) and T(1) and not(T(0));
H <= not(N(1)) and N(0) and not(T(1)) and T(0);
I <= N(1) and N(0) and T(1) and T(0);

clk_sel(0) <= N(0) xor T(0);
clk_sel(1) <= D or E or F or G or H or I;
clk_sel(2) <= A or B or C;

end rtl;