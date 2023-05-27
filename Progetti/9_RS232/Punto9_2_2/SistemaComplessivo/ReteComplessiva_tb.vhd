library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ReteComplessiva_tb is
end;

architecture bench of ReteComplessiva_tb is

  component ReteComplessiva
    Port ( 
          Start:  in std_logic    := '0';
          ResetA: in std_logic    := '0';
          ClockA: in std_logic    := '0';
          ResetB: in std_logic    := '0';
          ClockB: in std_logic    := '0'
    );
  end component;

  signal Start: std_logic := '0';
  signal ResetA: std_logic := '0';
  signal ClockA: std_logic := '0';
  signal ResetB: std_logic := '0';
  signal ClockB: std_logic := '0' ;

     constant clock_periodA: time := 60 ps;
     constant clock_periodB: time := 60 ps;

begin

  uut: ReteComplessiva port map ( Start  => Start,
                                  ResetA => ResetA,
                                  ClockA => ClockA,
                                  ResetB => ResetB,
                                  ClockB => ClockB );

  stimulus: process
  begin
  
    -- Put initialisation code here

    Start <= '1';
    -- Put test bench stimulus code here

    wait;
  end process;


  clockingA: process
  begin
    while True loop
      ClockA <= '0', '1' after clock_periodA / 2;
      wait for clock_periodA;
    end loop;
    wait;
  end process;

  clockingB: process
  begin
    while True loop
      ClockB <= '0', '1' after clock_periodB / 2;
      wait for clock_periodB;
    end loop;
    wait;
  end process;

end;
