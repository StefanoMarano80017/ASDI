library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity UC_A_tb is
end;

architecture bench of UC_A_tb is

  component UC_A
      Port ( 
          ClockA, ResetA: in std_logic:='0';
  		Start: in std_logic:='0';
  		OkB: in std_logic;
  		ReqA: out std_logic;
  		Tbe: in std_logic:='0';
  		EnWr: out std_logic:='0'
  );
  end component;

  signal ClockA, ResetA: std_logic:='0';
  signal Start: std_logic:='0';
  signal OkB: std_logic;
  signal ReqA: std_logic;
  signal Tbe: std_logic:='0';
  signal EnWr: std_logic:='0' ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: UC_A port map ( ClockA => ClockA,
                       ResetA => ResetA,
                       Start  => Start,
                       OkB    => OkB,
                       ReqA   => ReqA,
                       Tbe    => Tbe,
                       EnWr   => EnWr );

  stimulus: process
  begin
  
    -- Put initialisation code here
    OkB <= '0';

    ResetA <= '1';
    wait for 5 ns;
    ResetA <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here

    wait for 10ns; 
    Start <= '1';
    
    wait for 50ns;
    Start <= '0';
    OkB   <= '1';
    

    wait for 200ns;
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      ClockA <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;