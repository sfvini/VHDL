library ieee;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ex_process is
	port
	(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		
		gt : out std_logic;
		eq : out std_logic;
		lt : out std_logic
	);
end ex_process;

architecture incorreto of ex_process is
	signal a_signed, b_signed : signed(7 downto 0);
begin
	a_signed <= signed(a);
	b_signed <= signed(b);

	process (a_signed,b_signed)
	begin
		if (a_signed > b_signed) then
			gt <= '1';
		elsif (a_signed = b_signed) then
			eq <= '1';
		else
			lt <= '1';
		end if;
	end process;
end incorreto;

architecture correto of ex_process is
	signal a_signed, b_signed : signed(7 downto 0);
begin
	a_signed <= signed(a);
	b_signed <= signed(b);

	process (a_signed,b_signed)
	begin
		gt <= '0';
		eq <= '0';
		lt <= '0';
	
		if (a_signed > b_signed) then
			gt <= '1';
		elsif (a_signed = b_signed) then
			eq <= '1';
		else
			lt <= '1';
		end if;
	end process;
end correto;

configuration cfg_process of ex_process is
	--for incorreto end for;
	for correto end for;
end cfg_process;
