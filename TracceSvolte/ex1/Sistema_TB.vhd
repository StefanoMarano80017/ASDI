library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity SistemaComplessivo_tb is
end;

architecture bench of SistemaComplessivo_tb is

  component SistemaComplessivo
      Port ( 
          ClockA: in std_logic;
          ResetA: in std_logic;
          StartA: in std_logic;
          ClockB: in std_logic;
          ResetB: in std_logic
  );
  end component;

  signal ClockA: std_logic;
  signal ResetA: std_logic;
  signal StartA: std_logic;
  signal ClockB: std_logic;
  signal ResetB: std_logic;
  
  constant clock_periodA: time := 13ns;
  constant clock_periodB: time := 10ns;

begin

  uut: SistemaComplessivo port map ( ClockA => ClockA,
                                     ResetA => ResetA,
                                     StartA => StartA,
                                     ClockB => ClockB,
                                     ResetB => ResetB );

  stimulus: process
  begin
  
    -- Put initialisation code here

    StartA <= '1';
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