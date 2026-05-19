library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.NUMERIC_STD.ALL;

entity ex_02 is
	port
	(
        clk, reset: in STD_LOGIC;
		  d: in STD_LOGIC;
        q: out STD_LOGIC_VECTOR(2 downto 0)
	);
end ex_02;

architecture code of ex_02 is
    signal r_reg  : std_logic_vector(2 downto 0);
    signal r_next : std_logic_vector(2 downto 0);
begin

    -- Registrador
	  process(clk, reset)
    begin
        if (reset = '1') then
            r_reg <= (others => '0');

        elsif (clk'event and clk = '1') then
            r_reg <= r_next;
        end if;
    end process;

    process (r_reg)
    begin
        case r_reg is
            when "000" => r_next <= "011";
            when "011" => r_next <= "100";
            when "100" => r_next <= "101";
            when "101" => r_next <= "111";
            when others => r_next <= "000"; 
        end case;               
    end process;
	 
    q <= r_reg;

end code;

configuration code of ex_02 is 
	for code end for;
end;