library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Handshake_tb is
end;

architecture bench of Handshake_tb is
  component Handshake
      Port ( 
          ClockA: in std_logic;
          ClockB: in std_logic;
          ResetA: in std_logic;
          ResetB: in std_logic;
          Start:  in std_logic
      );
  end component;

  signal ClockA: std_logic;
  signal ClockB: std_logic;
  signal ResetA: std_logic;
  signal ResetB: std_logic;
  signal Start: std_logic ;
  
  
  constant clock_periodA: time := 20 ns;
  constant clock_periodB: time := 17 ns;

begin

  uut: Handshake port map ( ClockA => ClockA,
                            ClockB => ClockB,
                            ResetA => ResetA,
                            ResetB => ResetB,
                            Start  => Start );

  clockingB: process
  begin
    while True loop
      ClockB <= '0', '1' after clock_periodB/ 2;
      wait for clock_periodB;
    end loop;
    wait;
  end process;
  
  clockingA: process
  begin
    while True loop
      ClockA <= '0', '1' after clock_periodA/ 2;
      wait for clock_periodA;
    end loop;
    wait;
  end process;
    
  stimulus: process
  begin
            
     wait for 50ns;
     Start <= '1';

     wait for 700ns;
     Start <= '0';

    wait;
  end process;
end;
