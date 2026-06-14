library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_timer_de2_115 is
  port (
    CLOCK_50 : in std_logic;
    KEY      : in std_logic_vector (3 downto 0);
    HEX0     : out std_logic_vector (6 downto 0);
    HEX1     : out std_logic_vector (6 downto 0);
    HEX2     : out std_logic_vector (6 downto 0);
    HEX3     : out std_logic_vector (6 downto 0);
    HEX4     : out std_logic_vector (6 downto 0);	
    HEX5     : out std_logic_vector (6 downto 0)
  );

end entity;

architecture top of top_timer_de2_115 is

	component relogio_fsm
    port (
      clk, reset, ajuste, incrementa, decrementa : in std_logic;
      hora_in 			: in std_logic_vector (4 downto 0);
      min_in, seg_in : in std_logic_vector (5 downto 0);
      blink_h, blink_m, blink_s : out std_logic;
      load : out std_logic;
      hora_out 			: out std_logic_vector (4 downto 0);
      min_out, seg_out 	: out std_logic_vector (5 downto 0)
    );
  end component;

  component sync_keys
    port (
      clk, reset: in std_logic;
      keys_i: in std_logic_vector(2 downto 0);  -- entradas assíncronas
      keys_o: out std_logic_vector(2 downto 0)  -- saídas sincronizadas 
    );
  end component;

  component timer
    port (
      clk, reset : in std_logic;
		load : in std_logic;
		hour_i: in std_logic_vector(4 downto 0);
      sec_i,min_i: in std_logic_vector(5 downto 0);
      hour: out std_logic_vector(4 downto 0);      
      sec, min   : out std_logic_vector(5 downto 0)
    );
  end component;

  component bin2bcd is
    generic (N : positive := 16);
    port (
      clk, reset                   : in std_logic;
      binary_in                    : in std_logic_vector(N - 1 downto 0);
      bcd0, bcd1, bcd2, bcd3, bcd4 : out std_logic_vector(3 downto 0)
    );
  end component;
  
  component blink is
   port(
      clk, reset, en: in std_logic;
		blink	: out std_logic
   );
	end component;

  component bcd2ssd
    port (
      BCD : in std_logic_vector (3 downto 0);
      SSD : out std_logic_vector (6 downto 0)
    );
  end component;

  signal hourT, hourU: std_logic_vector(3 downto 0);
  signal minT, minU  : std_logic_vector(3 downto 0);
  signal secT, secU  : std_logic_vector(3 downto 0);

  signal hourT_blink, hourU_blink : std_logic_vector(3 downto 0);
  signal minT_blink, minU_blink   : std_logic_vector(3 downto 0);
  signal secT_blink, secU_blink   : std_logic_vector(3 downto 0);
  signal blink_o		: std_logic;
  signal blink_s, blink_m, blink_h	: std_logic;

  signal reset, load : std_logic;
  
  signal adjust		: std_logic;
  signal hour        : std_logic_vector(4 downto 0);
  signal min, sec    : std_logic_vector(5 downto 0);

  signal raw_keys, sinc_keys : std_logic_vector (2 downto 0);
  signal b_ajuste, b_incrementa, b_decrementa : std_logic;

  signal hour_new    : std_logic_vector(4 downto 0);
  signal min_new, sec_new : std_logic_vector(5 downto 0);
  signal is_setting  : std_logic;

begin

  reset <= not KEY(0);
  
  adjust <= not KEY(1);
	raw_keys(0) <= not KEY(1);
  raw_keys(1) <= not KEY(2);
  raw_keys(2) <= not KEY(3);

  inst_sync: sync_keys
  port map(
    clk   => CLOCK_50,
    reset => reset,
    keys_i => raw_keys,
    keys_o => sinc_keys
  );

  b_ajuste <= sinc_keys(0);
  b_incrementa <= sinc_keys(1);
  b_decrementa <= sinc_keys(2);

  inst_fsm: relogio_fsm
  port map(
    clk   => CLOCK_50,
    reset => reset,
    ajuste => b_ajuste,
    incrementa => b_incrementa,
    decrementa => b_decrementa,
    hora_in => hour,
    min_in => min,
    seg_in => sec,
    blink_h => blink_h,
    blink_m => blink_m,
    blink_s => blink_s,
    load => load,
    hora_out => hour_new,
    min_out => min_new,
    seg_out => sec_new
  );

  is_setting <= blink_h or blink_m or blink_s;
  
  t0 : timer
  port map(
    clk   => CLOCK_50,
    reset => reset,
	 load  =>  adjust,
	 hour_i=> std_logic_vector(to_unsigned(23,5)),
    sec_i => std_logic_vector(to_unsigned(30,6)),
	 min_i => std_logic_vector(to_unsigned(59,6)),
	 hour  => hour,
    sec   => sec,
    min   => min);

  bin2bcd_sec: bin2bcd
  generic map (
    N => 6)
  port map (
    clk => CLOCK_50, 
    reset => reset,
    binary_in => sec,
    bcd0 => secU,
    bcd1 => secT, 
    bcd2 => open,
    bcd3 => open,
    bcd4 => open);

  bin2bcd_min: bin2bcd
  generic map (
    N => 6)
  port map (
    clk => CLOCK_50, 
    reset => reset,
    binary_in => min,
    bcd0 => minU,
    bcd1 => minT, 
    bcd2 => open,
    bcd3 => open,
    bcd4 => open);

  bin2bcd_hour: bin2bcd
  generic map (
    N => 5)
  port map (
    clk => CLOCK_50, 
    reset => reset,
    binary_in => hour,
    bcd0 => hourU,
    bcd1 => hourT, 
    bcd2 => open,
    bcd3 => open,
    bcd4 => open);

	 
	blink1: blink
   port map(
      clk   => CLOCK_50,
		reset => reset,
		en    => adjust,
		blink =>	blink_o);
	 
	 
  secU_blink <= (others=>'1') when (blink_o='1' and blink_s='1') else
					 secU;
  secT_blink <= (others=>'1') when (blink_o='1' and blink_s='1') else
					 secT;
  minU_blink <= (others=>'1') when (blink_o='1' and blink_m='1') else
					 minU;
  minT_blink <= (others=>'1') when (blink_o='1' and blink_m='1') else
					 minT;
  hourU_blink <= (others=>'1') when (blink_o='1' and blink_h='1') else
					  hourU;
  hourT_blink <= (others=>'1') when (blink_o='1' and blink_h='1') else
					  hourT;				
				
  bcd_secU : bcd2ssd
  port map(
    BCD => secU_blink,
    SSD => HEX0);

  bcd_secT : bcd2ssd
  port map(
    BCD => secT_blink,
    SSD => HEX1);

  bcd_minU : bcd2ssd
  port map(
    BCD => minU_blink,
    SSD => HEX2);

  bcd_minT : bcd2ssd
  port map(
    BCD => minT_blink,
    SSD => HEX3);

  bcd_hourU : bcd2ssd
  port map(
    BCD => hourU_blink,
    SSD => HEX4);

  bcd_hourT : bcd2ssd
  port map(
    BCD => hourT_blink,
    SSD => HEX5);    

end top;