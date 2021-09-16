library ieee;
use ieee.std_logic_1164.all; 

entity ComparatorSync is
	port
	(
		entrada, CLK: in std_logic;
		saida: out std_logic
	);
end ComparatorSync;


architecture circuito of ComparatorSync is
type STATES is (EsperaAtivar, SaidaAtiva, EsperaDesativar);
signal saidaState: STATES := EsperaAtivar;
signal saidaNext: STATES := EsperaAtivar;

begin

	P1: process (clk) 
	begin
		if clk'event and clk = '1' then -- Resposta na transicao positiva do clock
			saidaState <= saidaNext;
		end if;
	end process;
	
	P2: process (entrada, saidaState)
	begin
		case saidaState is
			when EsperaAtivar =>
				if entrada = '1' then saidaNext <= SaidaAtiva; else saidaNext <= EsperaAtivar; end if;
				saida <= '0';
			when SaidaAtiva =>
				if entrada = '1' then saidaNext <= EsperaDesativar; else saidaNext <= EsperaAtivar; end if;	
				saida <= '1';
			when EsperaDesativar =>
				if entrada = '1' then saidaNext <= EsperaDesativar;	else saidaNext <= EsperaAtivar; end if;	
				saida <= '0';
		end case;		
	end process;
	
end circuito;