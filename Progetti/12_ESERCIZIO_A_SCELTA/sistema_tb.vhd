library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Seriale_finale_tb is
end;

architecture bench of Seriale_finale_tb is

  component Seriale_finale
      Port ( 
          ClockA: in std_logic;
          ClockB: in std_logic;
          resetA: in std_logic;
          resetB: in std_logic;
          StartA: in std_logic
      );
  end component;

  signal ClockA: std_logic;
  signal ClockB: std_logic;
  signal resetA: std_logic;
  signal resetB: std_logic;
  signal StartA: std_logic ;
  
  constant clock_periodA: time := 5 ns;
  constant clock_periodB: time := 6 ns;


begin

  uut: Seriale_finale port map ( ClockA => ClockA,
                                 ClockB => ClockB,
                                 resetA => resetA,
                                 resetB => resetB,
                                 StartA => StartA );

  stimulus: process
  begin
  
    -- Put initialisation code here

    StartA <= '1';
    wait for 50ns;
    StartA <= '0';
    -- Put test bench stimulus code here

    wait for 650ns;
    StartA <= '1';
    wait for 100ns;
    StartA <= '0';
    
    
    wait for 650ns;
    StartA <= '1';
    wait for 100ns;
    StartA <= '0';
    

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