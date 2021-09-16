
library ieee;
use ieee.std_logic_1164.all;

entity jogo is
port(CLK_500Hz, KEY0, KEY1, KEY2, KEY3: in std_logic;
     SW_IN: in std_logic_vector(7 downto 0);
     HEX0, HEX1, HEX2: out std_logic_vector(6 downto 0);
     LED_OUT: out std_logic_vector(7 downto 0));
end jogo;

architecture arc of jogo is
signal BTN0, BTN1, BTN2, BTN3, END_GAME, END_ROUND, R1: std_logic;
signal STATE: std_logic_vector(1 downto 0);

component datapath is
port (btn3, btn2, btn1, CLK_500Hz, r1: in std_logic;
      state: in std_logic_vector(1 downto 0);
      sw_entra: in std_logic_vector(7 downto 0);
      h0, h1, h2: out std_logic_vector(6 downto 0);
      led_out: out std_logic_vector (7 downto 0);
      end_game, end_round: out std_logic);
end component;

component controle is
port(CLK_500Hz, btn0, btn3, end_game, end_round: in std_logic;
     state: out std_logic_vector(1 downto 0);
     r1: out std_logic);
end component;

component ButtonSync is
port(KEY0, KEY1, KEY2, KEY3, CLK: in std_logic;
	 BTN0, BTN1, BTN2, BTN3: out std_logic);
end component;
begin

botoes: ButtonSync port map(KEY0,KEY1,KEY2,KEY3,CLK_500HZ, 
                            BTN0, BTN1, BTN2, BTN3);

dp: datapath port map(BTN3,BTN2,BTN1,CLK_500HZ, R1,
                      STATE, SW_IN,HEX0,HEX1,HEX2,
                      LED_OUT, END_GAME, END_ROUND);

control: controle port map(CLK_500HZ,BTN0, BTN3,
                           END_GAME, END_ROUND,
                           STATE, R1);
end arc;