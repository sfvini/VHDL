library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity ex_03 is
    port
    (
        clk, reset : in STD_LOGIC;
        up: in STD_LOGIC;
        q: out STD_LOGIC_VECTOR(7 downto 0)
    );
end ex_03;

architecture code of ex_03 is
    signal r_reg  : unsigned(7 downto 0);
    signal r_next : unsigned(7 downto 0);
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

    process (up, r_reg)
    begin
        if (up = '1') then
            r_next <= r_reg + 1;      
        else
            r_next <= r_reg - 1;      
        end if;
    end process;

    q <= std_logic_vector(r_reg);

end code;

configuration code of ex_03 is 
	for code end for;
end;	