library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity relogio_fsm is
    port (
        -- INPUTS
        clk, reset, ajuste, incrementa, decrementa : in std_logic;
        hora_in        : in std_logic_vector (4 downto 0); 
        min_in, seg_in : in std_logic_vector (5 downto 0); 
        
        -- OUTPUTS
        blink_h, blink_m, blink_s : out std_logic;
        load             : out std_logic;
        hora_out         : out std_logic_vector (4 downto 0);
        min_out, seg_out : out std_logic_vector (5 downto 0)
    );
end relogio_fsm;

architecture estados of relogio_fsm is
    -- ESTADOS
    type mc_state_type is (
        idle, 
        ajuste_h, incrementa_h, decrementa_h, 
        ajuste_m, incrementa_m, decrementa_m, 
        ajuste_s, incrementa_s, decrementa_s
    );
    signal state_reg, next_state : mc_state_type;
begin

    process(clk, reset)
    begin
        if(reset = '1') then
            state_reg <= idle;
        elsif rising_edge(clk) then
            state_reg <= next_state;
        end if;
    end process;

    process(state_reg, ajuste, incrementa, decrementa, hora_in, min_in, seg_in)
    begin
        next_state <= state_reg;
        hora_out   <= hora_in;
        min_out    <= min_in;
        seg_out    <= seg_in;
        blink_h    <= '0';
        blink_m    <= '0';
        blink_s    <= '0';
        load       <= '0';

        case state_reg is
            when idle =>
                if (ajuste = '1') then
                    next_state <= ajuste_h;
                end if;


            when ajuste_h =>
                blink_h <= '1'; 
                load    <= '1'; 
                if (ajuste = '1') then
                    next_state <= ajuste_m;
                elsif (incrementa = '1') then
                    next_state <= incrementa_h;
                elsif (decrementa = '1') then
                    next_state <= decrementa_h;
                end if;

            when incrementa_h =>
                blink_h <= '1'; 
                load    <= '1';
                if unsigned(hora_in) = 23 then
                    hora_out <= std_logic_vector(to_unsigned(0, 5));
                else
                    hora_out <= std_logic_vector(unsigned(hora_in) + 1);
                end if;
                next_state <= ajuste_h; 

            when decrementa_h =>
                blink_h <= '1'; 
                load    <= '1';
                if unsigned(hora_in) = 0 then
                    hora_out <= std_logic_vector(to_unsigned(23, 5));
                else
                    hora_out <= std_logic_vector(unsigned(hora_in) - 1);
                end if;
                next_state <= ajuste_h; 

 
            when ajuste_m =>
                blink_m <= '1';
                load    <= '1'; 
                if (ajuste = '1') then
                    next_state <= ajuste_s;
                elsif (incrementa = '1') then
                    next_state <= incrementa_m;
                elsif (decrementa = '1') then
                    next_state <= decrementa_m;
                end if;

            when incrementa_m =>
                blink_m <= '1';
                load    <= '1';
                if unsigned(min_in) = 59 then
                    min_out <= std_logic_vector(to_unsigned(0, 6));
                else
                    min_out <= std_logic_vector(unsigned(min_in) + 1);
                end if;
                next_state <= ajuste_m;

            when decrementa_m =>
                blink_m <= '1';
                load    <= '1';
                if unsigned(min_in) = 0 then
                    min_out <= std_logic_vector(to_unsigned(59, 6)); 
                else
                    min_out <= std_logic_vector(unsigned(min_in) - 1);
                end if;
                next_state <= ajuste_m;


            when ajuste_s =>
                blink_s <= '1';
                load    <= '1'; 
                if (ajuste = '1') then
                    next_state <= idle;
                elsif (incrementa = '1') then
                    next_state <= incrementa_s;
                elsif (decrementa = '1') then
                    next_state <= decrementa_s;
                end if;

            when incrementa_s =>
                blink_s <= '1';
                load    <= '1';
                if unsigned(seg_in) = 59 then
                    seg_out <= std_logic_vector(to_unsigned(0, 6));
                else
                    seg_out <= std_logic_vector(unsigned(seg_in) + 1);
                end if;
                next_state <= ajuste_s;

            when decrementa_s =>
                blink_s <= '1';
                load    <= '1';
                if unsigned(seg_in) = 0 then
                    seg_out <= std_logic_vector(to_unsigned(59, 6));
                else
                    seg_out <= std_logic_vector(unsigned(seg_in) - 1);
                end if;
                next_state <= ajuste_s;

            when others =>
                next_state <= idle;

        end case;
    end process;
end estados;