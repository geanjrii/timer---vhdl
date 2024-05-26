library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Timer is
    generic (ClockFrequencyHz : integer);
    port (
        Clk : in std_logic;
        Reset : in std_logic;
        Y : out std_logic;
        Seconds : inout integer;
        Minutes : inout integer;
        Hours : inout integer);
end Timer;

architecture rtl of Timer is
    -- Sinal para contagem de períodos de clock
    signal Ticks : integer;
begin
    process (Clk)
    begin
        if rising_edge(Clk) then
            -- Se o sinal de reset negativo estiver ativo
            if Reset = '1' then
                Ticks <= 0;
                Seconds <= 0;
                Y <= '0';
                Minutes <= 0;
                Hours <= 0;
            else
                -- Verdadeiro uma vez a cada segundo
                if Ticks = ClockFrequencyHz - 1 then
                    Ticks <= 0;
                    -- Verdadeiro uma vez a cada minuto
                    if Seconds = 59 then
                        Seconds <= 0;
                        -- Verdadeiro uma vez a cada hora
                        if Minutes = 59 then
                            Minutes <= 0;
                            -- Verdadeiro uma vez por dia
                            if Hours = 23 then
                                Hours <= 0;
                            else
                                Hours <= Hours + 1;
                            end if;
                        else
                            Minutes <= Minutes + 1;
                        end if;
                        
                        -- Checa se deu 2 minutos após o incremento
                        if Hours = 0 and Minutes = 1 then
                            Y <= '1';
                        else
                            Y <= '0';
                        end if;
                        
                    else
                        Seconds <= Seconds + 1;
                    end if;                 
                    
                else
                    Ticks <= Ticks + 1;
                end if;
            end if;
        end if;
    end process;
end rtl;
