library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity UC_B_tb is
end;

architecture bench of UC_B_tb is

  component UC_B
      Port ( 
          ClockB, ResetB: in std_logic;
  		OkB: out std_logic;
  		ReqA: in std_logic;
  		RDA: in std_logic:='0';
  		EnRD: out std_logic:='0';
  		OE, PE, FE: in std_logic;
  		RD_mem: out std_logic;
  		OutCont: out std_logic_vector(2 downto 0) := (others => '0')
  );
  end component;

  signal ClockB, ResetB: std_logic;
  signal OkB: std_logic;
  signal ReqA: std_logic;
  signal RDA: std_logic:='0';
  signal EnRD: std_logic:='0';
  signal OE, PE, FE: std_logic;
  signal RD_mem: std_logic;
  signal OutCont: std_logic_vector(2 downto 0) := (others => '0') ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: UC_B port map ( ClockB  => ClockB,
                       ResetB  => ResetB,
                       OkB     => OkB,
                       ReqA    => ReqA,
                       RDA     => RDA,
                       EnRD    => EnRD,
                       OE      => OE,
                       PE      => PE,
                       FE      => FE,
                       RD_mem  => RD_mem,
                       OutCont => OutCont );

  stimulus: process
  begin
  
    OE <= '0';
    PE <= '0';
    FE <= '0';
  
    -- Put initialisation code here

    ResetB <= '1';
    wait for 5 ns;
    ResetB <= '0';
    wait for 5 ns;

    -- Put test bench stimulus code here
    wait for 10ns;
    ReqA <= '1';
    
    wait for 20ns;
    RDA  <= '1';
    ReqA <= '0';


    wait for 200ns;
    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      ClockB <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;

