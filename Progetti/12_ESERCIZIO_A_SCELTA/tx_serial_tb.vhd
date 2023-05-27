library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Tx_seriale_tb is
end;

architecture bench of Tx_seriale_tb is

  component Tx_seriale
      port ( 
          Data_out: out std_logic;
          ReqA: out std_logic;
          okB: in std_logic;
          Clock: in std_logic;
          reset: in std_logic;
          StartA: in std_logic
      );
  end component;

  signal Data_out: std_logic;
  signal ReqA: std_logic;
  signal okB: std_logic;
  signal Clock: std_logic;
  signal reset: std_logic;
  signal StartA: std_logic ;

  constant clock_period: time := 10 ns;

begin

  uut: Tx_seriale port map ( Data_out => Data_out,
                             ReqA     => ReqA,
                             okB      => okB,
                             Clock    => Clock,
                             reset    => reset,
                             StartA   => StartA );

  stimulus: process
  begin
  
    StartA <= '1';
    okB <= '0';
    
    while True loop
      okB <= '0', '1' after 20ns;
      wait for 40ns;
    end loop; 
    wait;
  end process;



clocking: process
  begin
    while True loop
      Clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
