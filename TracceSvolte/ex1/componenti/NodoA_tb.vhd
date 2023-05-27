library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity NodoA_tb is
end;

architecture bench of NodoA_tb is

  component NodoA
      Port ( 
          ClockA: in std_logic;
          ResetA: in std_logic;
          StartA: in std_logic;
          ReqA: out std_logic;
          okB:  in std_logic;
          Data: out std_logic_vector(4 downto 0)
  );
  end component;

  signal ClockA: std_logic;
  signal ResetA: std_logic;
  signal StartA: std_logic;
  signal ReqA: std_logic;
  signal okB: std_logic;
  signal Data: std_logic_vector(4 downto 0);
  
  constant clock_period: time := 10ns;

begin

  uut: NodoA port map ( ClockA => ClockA,
                        ResetA => ResetA,
                        StartA => StartA,
                        ReqA   => ReqA,
                        okB    => okB,
                        Data   => Data );

  stimulus: process
  begin
  
    -- Put initialisation code here
    okB <= '0';
    StartA <= '1';
    
    wait for 40ns;
    okB <= '1';
    
    wait for 50ns;
    okB <= '0';
    
    wait for 30ns;
    okB <= '1';

    -- Put test bench stimulus code here

    wait;
  end process;


  clocking: process
  begin
    while True loop
      ClockA <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;
end;
