library ieee;
use ieee.std_logic_1164.all;

entity display7seg is 

	port (
		sw: in std_logic_vector (3 downto 0);
		hex0: out std_logic_vector (6 downto 0)
	);
end display7seg;

architecture code of display7seg is
begin
	process(sw)
	
		begin
			case sw is					 --abcdefg
				when "0000" => hex0 <= "0000001"; -- 0
            when "0001" => hex0 <= "1001111"; -- 1
            when "0010" => hex0 <= "0010010"; -- 2
            when "0011" => hex0 <= "0000110"; -- 3
            when "0100" => hex0 <= "1001100"; -- 4
            when "0101" => hex0 <= "0100100"; -- 5
            when "0110" => hex0 <= "0100000"; -- 6
            when "0111" => hex0 <= "0001111"; -- 7
            when "1000" => hex0 <= "0000000"; -- 8
            when "1001" => hex0 <= "0001100"; -- 9
            when others => hex0 <= "1111111"; -- Apagado
			end case;
	end process;
end architecture;

configuration c_display7seg of display7seg is
    for code end for;
end configuration;