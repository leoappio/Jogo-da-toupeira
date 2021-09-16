library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity FSM_clock is
	port (	clk_500Hz: in std_logic;
				reset: in std_logic;
				CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz: out std_logic
			);
end entity;

architecture divisor of FSM_clock is
	signal contador025, contador05, contador075, contador1, contador125, contador15, contador2: std_logic_vector(11 downto 0); -- Registra valor da contagem
	
	begin
		P1: process(clk_500Hz, reset, contador025, contador05, contador075, contador1, contador125, contador15, contador2)
		
			begin
			
			 if reset= '1' then
				 contador025 <= x"000";
				 contador05  <= x"000";
				 contador075 <= x"000";
				 contador1   <= x"000";
				 contador125 <= x"000";
				 contador15  <= x"000";
				 contador2   <= x"000";
				 
				 CLK_0_25Hz  <= '1';
				 CLK_0_5Hz   <= '1';
				 CLK_0_75Hz  <= '1';
				 CLK_1Hz     <= '1';
				 CLK_1_25Hz  <= '1';
				 CLK_1_5Hz   <= '1';
				 CLK_2Hz     <= '1';
				
			 elsif clk_500Hz'event and clk_500Hz = '1' then
				
				--0,25Hz = 4s = 500Hzx4 = 2000
				if contador025 < x"3E7" then  --se contador < 999 (3E7 em hexadecimal)
					CLK_0_25Hz <= '1';
					contador025 <= contador025 + 1;
					
				elsif contador025 < x"7CF" then  --se contador < 1999 (7CF em hexadecimal)
					CLK_0_25Hz <= '0';
					contador025 <= contador025 + 1;
				
				else 
					contador025 <= x"000";
					CLK_0_25Hz <= '1';
				end if;
				
				
				--0,5Hz = 2s = 500Hzx2 = 1000
				if contador05 < x"1F3" then  --se contador < 499 (1F3 em hexadecimal)
					CLK_0_5Hz <= '1';
					contador05 <= contador05  + 1;
					
				elsif contador05 < x"3E7" then  --se contador < 999 (3E7 em hexadecimal)
					CLK_0_5Hz <= '0';
					contador05 <= contador05  + 1;
				
				else 
					contador05 <= x"000";
					CLK_0_5Hz <= '1';
				end if;
				
				
				--0,75Hz = 1,333...s = 500Hzx1,333... = 666,66... par mais proximo: 666 
				if contador075 < x"14C" then  --se contador < 332 (14C em hexadecimal)
					CLK_0_75Hz <= '1';
					contador075 <= contador075 + 1;
					
				elsif contador075 < x"299" then  --se contador < 665 (299 em hexadecimal)
					CLK_0_75Hz <= '0';
					contador075 <= contador075 + 1;
				
				else 
					contador075 <= x"000";
					CLK_0_75Hz <= '1';
				end if;
				
				--preencher o restante...

				--1Hz = 1s = 500Hzx1 = 500
				if contador1 < x"F9" then  --se contador < 249 (F9 em hexadecimal)
				    CLK_1Hz <= '1';
				    contador1 <= contador1 + 1;
				    
				elsif contador1 < x"1F3" then  --se contador < 499 (1F3 em hexadecimal)
				    CLK_1Hz <= '0';
				    contador1 <= contador1 + 1;
				    
				else
				    contador1 <= x"000";
				    CLK_1Hz <= '1';
				end if;


				--1,25Hz = 0,8s = 500Hzx0,8 = 400
				if contador125 < x"C7" then  --se contador < 199 (C7 em hexadecimal)
					CLK_1_25Hz <= '1';
					contador125 <= contador125 + 1;
					
				elsif contador125 < x"18F" then  --se contador < 399 (18F em hexadecimal)
					CLK_1_25Hz <= '0';
					contador125 <= contador125 + 1;
				
				else 
					contador125 <= x"000";
					CLK_1_25Hz <= '1';
				end if;
				
				
				--1,5Hz = 0,666...s = 500Hzx0,666... = 333,33... par mais proximo: 334
				if contador15 < x"A6" then  --se contador < 166 (A6 em hexadecimal)
					CLK_1_5Hz <= '1';
					contador15 <= contador15 + 1;
					
				elsif contador15 < x"14D" then  --se contador < 333 (14D em hexadecimal)
					CLK_1_5Hz <= '0';
					contador15 <= contador15 + 1;
				
				else 
					contador15 <= x"000";
					CLK_1_5Hz <= '1';
				end if;
				
			
				--2Hz = 0,5 segs = 500Hzx0,5 = 250
				if contador2 < x"7C" then  --se contador < 124 (7C em hexadecimal)
					CLK_2Hz <= '1';
					contador2 <= contador2  + 1;
					
				elsif contador2 < x"F9" then  --se contador < 249 (F9 em hexadecimal)
					CLK_2Hz <= '0';
					contador2 <= contador2  + 1;
				
				else 
					contador2 <= x"000";
					CLK_2Hz <= '1';
				end if;
				
			 end if;
			 
		end process;
			
end architecture;