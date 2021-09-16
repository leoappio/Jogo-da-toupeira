library ieee;
use ieee.std_logic_1164.all;

entity datapath is 
port (btn3, btn2, btn1, CLK_500Hz, r1: in std_logic;
      state: in std_logic_vector(1 downto 0);
      sw_entra: in std_logic_vector(7 downto 0);
      h0, h1, h2: out std_logic_vector(6 downto 0);
      led_out: out std_logic_vector (7 downto 0);
      end_game, end_round: out std_logic);
end datapath;

architecture arqdata of datapath is
signal toup, score, sai_seq1, sai_seq2, sai_seq3, sai_seq4: std_logic_vector(7 downto 0);
signal sai_h2s0, sai_h2s2, sai_h1s2, sai_h1s3, d7seg: std_logic_vector(6 downto 0);
signal trial: std_logic_vector(4 downto 0);
signal entra_h00e0, entra_h00e1, entra_h02e1, sai_h0s0, sai_h0s2, sai_h0s3, sai_m0: std_logic_vector(3 downto 0);
signal TRIAL2_0, clk_sel, ckproc_sel: std_logic_vector(2 downto 0);
signal seq, nivel, TRIAL4_3: std_logic_vector(1 downto 0);
signal pace, setup_sel, state_01, state_10, TCN3, TC7, enable_trial, reset_toupeira: std_logic;
signal out_demux0, out_demux1, comp_score, acerto_comp_async, enable_counter_score: std_logic;
signal reset_fsm,clk_0_25Hz, clk_0_5Hz, clk_0_75Hz, clk_1Hz, clk_1_25Hz, clk_1_5Hz, clk_1_2Hz: std_logic;

component demux is
port(ent, sel: in std_logic;
    out0, out1: out std_logic);
end component;

component mux2_1x4 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(3 downto 0);
    saida: out std_logic_vector(3 downto 0));
end component;

component mux2_1x7 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(6 downto 0);
    saida: out std_logic_vector(6 downto 0));
end component;

component mux2_1x8 is
port(sel: in std_logic;
    ent0, ent1: in std_logic_vector(7 downto 0);
    saida: out std_logic_vector(7 downto 0));
end component;

component mux4_1x4 is
port(
	sel: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(3 downto 0);
    ss: out std_logic_vector(3 downto 0));
end component;

component mux4_1x7 is
port(
	sel: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(6 downto 0);
    ss: out std_logic_vector(6 downto 0));
end component;

component Counter_trial is
port (CLK, E, R: in std_logic;
      TCN3: out std_logic;
      TRIAL4_3: out std_logic_vector(1 downto 0) );
end component;

component Counter_toupeira is
port (CLK, E, R: in std_logic;
      TC7: out std_logic;
      TRIAL2_0: out std_logic_vector(2 downto 0) );
end component;

component seq1 is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end component;

component seq2 is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end component;

component seq3 is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end component;

component seq4 is
  port ( address : in std_logic_vector(4 downto 0);
         data : out std_logic_vector(7 downto 0) );
end component;

component mux4_1x8 is
port(seq: in std_logic_vector(1 downto 0);
    ent0, ent1, ent2, ent3: in std_logic_vector(7 downto 0);
    toup: out std_logic_vector(7 downto 0));
end component;

component flip_flop_t is port (
	CLK: in std_logic;
	E: in std_logic;
	Q: out std_logic );
end component;

component Counter_nivel is 
port (CLK: in std_logic;
      E: in std_logic;
      nivel: out std_logic_vector(1 downto 0) );
end component;

component Counter_seq is 
port (CLK: in std_logic;
      E: in std_logic;
      seq: out std_logic_vector(1 downto 0) );
end component;

component comparator is
port(chaves, toupeira: in std_logic_vector(7 downto 0);
    saida: out std_logic);
end component;

component ComparatorSync is
port(entrada, CLK: in std_logic;
	 saida: out std_logic);
end component;

component Counter_score is 
port (CLK, E, R: in std_logic;
      data: in std_logic_vector(1 downto 0);
      score: out std_logic_vector(7 downto 0) );
end component;

component FSM_clock is
port (clk_500Hz: in std_logic;
	  reset: in std_logic;
	  CLK_0_25Hz, CLK_0_5Hz, CLK_0_75Hz, CLK_1Hz, CLK_1_25Hz, CLK_1_5Hz, CLK_2Hz: out std_logic);
end component;

component mux8_1xPace is
port(ckproc_sel: in std_logic_vector(2 downto 0);
     clk_0_25Hz,
     clk_0_5Hz,
     clk_0_75Hz,
     clk_1Hz,
     clk_1_25Hz,
     clk_1_5Hz,
     clk_1_2Hz: in std_logic;
    pace: out std_logic);
end component;

component mux2_1x3 is
port(state: in std_logic;
    clk_sel: in std_logic_vector(2 downto 0);
    ckproc_sel: out std_logic_vector(2 downto 0));
end component;

component logica_trial is
port(N, T: in std_logic_vector(1 downto 0); 
     clk_sel: out std_logic_vector(2 downto 0));
end component;

component dec7seg is
port (En:  in std_logic_vector(3 downto 0);
      Sa:  out std_logic_vector(6 downto 0));
end component;

begin

state_01 <= (not(state(1))) and state(0);
state_10 <= state(1) and (not(state(0)));
end_round <= ((TCN3 and TC7) and (not(pace)));
end_game <= ((not(TCN3)) and TC7);


-- blocos de counter trial e counter toupeira
enable_trial <= state_10 and btn3;
reset_toupeira <= state_10 or r1;
trial_counter: Counter_trial port map(CLK_500Hz, enable_trial, r1, TCN3, TRIAL4_3);
toup_counter: Counter_toupeira port map(pace, state_01, reset_toupeira, TC7, TRIAL2_0);

trial <= TRIAL4_3 & TRIAL2_0;


-- bloco seletor de sequencia
bloco_s1: seq1 port map(trial, sai_seq1);
bloco_s2: seq2 port map(trial, sai_seq2); 
bloco_s3: seq3 port map(trial, sai_seq3); 
bloco_s4: seq4 port map(trial, sai_seq4);
m418: mux4_1x8 port map(seq, sai_seq1, sai_seq2, sai_seq3, sai_seq4, toup);


-- LEDR(7..0)
m218: mux2_1x8 port map(state_01, "00000000", toup, led_out);


-- bloco dos contadores de nivel e sequencia
flp_flopt: flip_flop_t port map(CLK_500Hz, btn1, setup_sel);
dmx: demux port map(btn2, setup_sel, out_demux0, out_demux1);
cnt_nivel: Counter_nivel port map(CLK_500Hz, out_demux0, nivel);
cnt_seq: Counter_seq port map(CLK_500Hz, out_demux1, seq);


--bloco do contador score
cprt: comparator port map(sw_entra, toup, comp_score);
cprt_sync: ComparatorSync port map(comp_score, CLK_500Hz, acerto_comp_async);
enable_counter_score <= state_01 and acerto_comp_async;
cntr_score: Counter_score port map(CLK_500Hz, enable_counter_score, r1, TRIAL4_3, score);


--bloco fsm clock
reset_fsm <= r1 or btn3;
fsm: FSM_clock port map(CLK_500Hz, reset_fsm,clk_0_25Hz, clk_0_5Hz,
clk_0_75Hz, clk_1Hz, clk_1_25Hz, clk_1_5Hz, clk_1_2Hz);
lgc_trial: logica_trial port map(nivel, TRIAL4_3, clk_sel);
m213: mux2_1x3 port map(state(1), clk_sel, ckproc_sel);
m81Pace: mux8_1xPace port map(ckproc_sel, clk_0_25Hz, clk_0_5Hz, 
clk_0_75Hz, clk_1Hz, clk_1_25Hz, clk_1_5Hz, clk_1_2Hz, pace);


-- HEX2 
m20: mux2_1x7 port map( setup_sel, "1000111", "1110001", sai_h2s0); --L, J
m22: mux2_1x7 port map( pace, "0001100", "0000110", sai_h2s2); --P, E
hs2: mux4_1x7 port map( state, sai_h2s0, "0001100", sai_h2s2, sai_h2s2, h2); --P



-- HEX1
decseg: dec7seg port map(score(7 downto 4), d7seg);
m12: mux2_1x7 port map( pace, d7seg, "1000000", sai_h1s2); --apagado
m13: mux2_1x7 port map( pace, d7seg, "0101011", sai_h1s3); --n
hs1: mux4_1x7 port map( state,"1111111", d7seg, sai_h1s2, sai_h1s3, h1); --apagado


-- HEX0
entra_h00e0 <= "00" & nivel;
entra_h00e1 <= "00" & seq;
entra_h02e1 <= "00" & trial(4 downto 3);
m00: mux2_1x4 port map( setup_sel, entra_h00e0, entra_h00e1, sai_h0s0);
m02: mux2_1x4 port map( pace, score(3 downto 0), entra_h02e1, sai_h0s2);
m03: mux2_1x4 port map( pace, score(3 downto 0), "1101", sai_h0s3);
m0: mux4_1x4 port map( state, sai_h0s0, score(3 downto 0), sai_h0s2, sai_h0s3, sai_m0);
dec7: dec7seg port map(sai_m0, h0);

end arqdata;
