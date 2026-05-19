library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_01 is
	port
	(
	clk, reset: in STD_LOGIC;
        d: in STD_LOGIC;
        control: in STD_LOGIC_VECTOR(1 downto 0); -- opçoes (pausar, deslocar para a esquerda, deslocar para a direita e carregar)
        d_to_right: in STD_LOGIC;
        d_to_left: in STD_LOGIC;
        entrada: in STD_LOGIC_VECTOR(3 downto 0); -- entrada de 4 bits
        q: out STD_LOGIC_VECTOR(3 downto 0)
	);
	end ex_01;
	
-- 00 pausar
-- 10 esquerda
-- 01 direita
-- 11 carregar
	
	architecture code of ex_01 is
    signal r_reg  : std_logic_vector(3 downto 0);
    signal r_next : std_logic_vector(3 downto 0);
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
	 
	 process (control, r_reg, entrada, d_to_left, d_to_right)
    begin
        case control is 
            when "00" => r_next <= r_reg;
            when "01" => r_next <= d_to_right & r_reg(3 downto 1); -- concatena para direita
            when "10" => r_next <= r_reg(2 downto 0) & d_to_left; -- concatena para a esquerda
            when "11" => r_next <= entrada;
            when others => r_next <= r_reg;
        end case;
    end process;

    q <= r_reg;
end code;

configuration code of ex_01 is 
    for code end for;
end configuration;