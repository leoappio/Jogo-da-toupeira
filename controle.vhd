library ieee;
use ieee.std_logic_1164.all;

entity controle is port (
  CLK_500Hz, btn0, btn3, end_game, end_round: in std_logic;
  state: out std_logic_vector(1 downto 0);
  r1: out std_logic := '0');
end controle;

architecture arc of controle is
  type STATES is (Start,Setup,Play,Next_Round, End_of_game);
  signal EstadoAtual, ProxEstado: STATES;
begin
  
  -- logica de proximo estado --
  process(CLK_500Hz,btn0)
  begin
    if (btn0 = '1') then
	  EstadoAtual <= Start;
	elsif (CLK_500Hz'event AND CLK_500Hz = '1') then 
  	  EstadoAtual <= ProxEstado;
	end if;
  end process;
  
  -- logica de saida --
  process(EstadoAtual, btn3, end_round, end_game)
  begin
    case EstadoAtual is
      when Start =>
        r1 <= '1';
        ProxEstado <= Setup;
	  when Setup =>
	    r1 <= '0';
	    state <= "00";
	    if(btn3 = '1') then
            ProxEstado <= Play;
        end if;
      when Play =>
        state <= "01";
        if(end_round = '1') then
            ProxEstado <= Next_Round;
        end if;
        if (end_game = '1') then
            ProxEstado <= End_of_game;
        end if;
      when Next_Round =>
        state <= "10";
        if(btn3 = '1') then
            ProxEstado <= Play;
        end if;
        if(end_game = '1') then
            ProxEstado <= End_of_game;
        end if;
      when End_of_game =>
        state <= "11";
    end case;
  end process;
end arc;
