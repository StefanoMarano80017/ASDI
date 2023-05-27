library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ContMod60_tb is
end;

architecture bench of ContMod60_tb is
  constant CLK_period: time := 10 ns;

  component ContMod60
    Port (
         Clk : in std_logic;
        Rst :in std_logic;
        Cont : out std_logic_vector(0 to 5) 
   );
  end component;

  signal Clock: std_logic;
  signal Reset: std_logic;
  signal Output: std_logic_vector(0 to 5) ;

begin

  uut: ContMod60 port map ( Clk      => Clock,
                            Rst => Reset,
                            Cont     => Output );
                            
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
       wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;


    -- Put test bench stimulus code here

    wait;
  end process;


end;
