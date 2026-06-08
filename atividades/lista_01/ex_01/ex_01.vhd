library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ex_01 is
    port (
        clk, reset      : in  STD_LOGIC;
        control         : in  STD_LOGIC_VECTOR(2 downto 0); 
        d_to_right      : in  STD_LOGIC;
        d_to_left       : in  STD_LOGIC;
        entrada         : in  STD_LOGIC_VECTOR(3 downto 0);
        q               : out STD_LOGIC_VECTOR(3 downto 0)
    );
end ex_01;

architecture code of ex_01 is
    signal r_reg  : STD_LOGIC_VECTOR(3 downto 0);
    signal r_next : STD_LOGIC_VECTOR(3 downto 0);
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
	 
	     -- 000: pausar
        -- 001: deslocar para a direita (d_to_right)
        -- 010: deslocar para a esquerda (d_to_left)
        -- 011: rotacionar a direita
        -- 100: rotacionar a esquerda
        -- 101: carregar

    process (control, r_reg, entrada, d_to_left, d_to_right)
    begin
        case control is
            when "000" => 
                r_next <= r_reg; 
                
            when "001" => 
                r_next <= d_to_right & r_reg(3 downto 1); 
                
            when "010" => 
                r_next <= r_reg(2 downto 0) & d_to_left;
                
            when "011" => 
                r_next <= r_reg(0) & r_reg(3 downto 1);
                
            when "100" => 
                r_next <= r_reg(2 downto 0) & r_reg(3); 
                
            when "101" => 
                r_next <= entrada; 
                
            when others => 
                r_next <= r_reg; 
        end case;
    end process;

    q <= r_reg;
end code;