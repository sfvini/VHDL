library IEEE;
use IEEE.std_logic_1164.all;

entity mux4x1 is
	port
	(
		X: in  bit_vector (3 downto 0);
      Sel : in bit_vector (1 downto 0);
		Y : out bit
	);
end entity;

architecture v_logica of mux4x1 is

begin
 Y <= (X(0) and (not Sel(1)) and (not Sel(0))) or (X(1) and (not Sel(1)) and Sel(0)) or (X(2) and Sel(1) and (not Sel(0))) or (X(3) and Sel(1) and Sel(0));
		end architecture;

architecture v_when_else of mux4x1 is

begin
 Y <= X(0) when Sel = "00" else
		X(1) when Sel = "01" else
		X(2) when Sel = "10" else	
		X(3);
end architecture;

architecture v_with_select of mux4x1 is

begin
 with Sel select
 Y <= X(0) when "00",
		X(1) when "01",
		X(2) when "10",
		X(3) when others;
end architecture;

configuration v1_mux4x1 of mux4x1 is
FOR v_logica END FOR;
end configuration;

configuration v2_mux4x1 of mux4x1 is
	FOR v_when_else END FOR;
end configuration;

configuration v3_mux4x1 of mux4x1 is
	FOR v_with_select END FOR;
end configuration;