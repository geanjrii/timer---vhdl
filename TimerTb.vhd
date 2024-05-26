library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TimerTb is
end entity;

architecture sim of TimerTb is

    -- Estamos desacelerando o clock para acelerar o tempo de simulação
    constant ClockFrequencyHz : integer := 10; -- 10 Hz
    constant ClockPeriod : time := 1000 ms / ClockFrequencyHz;

    signal Clk : std_logic := '1';
    signal Reset : std_logic := '1';
    signal Y : std_logic := '0';
    signal Seconds : integer;
    signal Minutes : integer;
    signal Hours : integer;
    
    component Timer is
        generic (
            ClockFrequencyHz :  integer
        ); port (
            Clk              : in std_logic;
            Reset            : in std_logic;
            Y                :  out std_logic;
            Seconds          : inout integer;
            Minutes          : inout integer;
            Hours            : inout integer
        );
    end component Timer;

begin
    -- O dispositivo em teste
    i_Timer : Timer
    generic map(ClockFrequencyHz => ClockFrequencyHz)
    port map(
        Clk => Clk,
        Reset => Reset,
        Y => Y,
        Seconds => Seconds,
        Minutes => Minutes,
        Hours => Hours);
    -- Processo para gerar o clock
    Clk <= not Clk after ClockPeriod / 2;
    Reset <= not Reset after 300000 ms;
    process is
    begin
        wait until rising_edge(Clk);
        wait until rising_edge(Clk);
        --Reset <= '0';
        wait;
    end process;
end architecture;