library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FlipFlopT_tb is
end;

architecture bench of FlipFlopT_tb is

  component FlipFlopT
      Port ( 
               clk :in std_logic;
               rst :in std_logic;
               set :in std_logic;
               setVal :in std_logic;
               y :out std_logic
      );
  end component;

  signal Clock: std_logic;
  signal Reset: std_logic;
  signal Set: std_logic ;
  signal SetIn: std_logic ;
  signal Output: std_logic ;
  

  constant CLK_period: time := 10 ns;
  

begin

  uut: FlipFlopT port map ( clk => Clock,
                            rst => Reset,
                            set => Set,
                            setVal => SetIn,
                            y   => Output );

    -- Clock process definitions
   CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock <= '1';
		wait for CLK_period/2;
   end process;
  
  stimulus: process
  
  begin
  
    -- Put initialisation code here
    wait for 10ns;
     set <='1' ;
     setIn <='1';
      wait for 10ns;
     set <='0';
    
    wait for 10ns;
    Reset<='1';
     wait for 10ns;
    Reset<='0';
     
     wait for 10ns;
     set <='0' ;
     setIn <='0';
     wait for 10ns;
    Reset<='1';
     wait for 10ns;
    Reset<='0';
    
    
    


    -- Put test bench stimulus code here

    
  end process;

  
end;