
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FlipFlopT_tb is
end;

architecture bench of FlipFlopT_tb is

  component FlipFlopT
   Port ( 
          clock : in STD_LOGIC;
          tin : in STD_LOGIC;
          q : out STD_LOGIC
   );
  end component;

  signal clock: STD_LOGIC;
  signal tin: STD_LOGIC;
  signal q: STD_LOGIC ;

  constant CLK_period: time := 10 ns;
  

begin

  uut: FlipFlopT port map ( clock => clock,
                            tin   => tin,
                            q     => q );
    -- Clock process definitions
   CLK_process :process
   begin
		clock <= '0';
		wait for CLK_period/2;
		clock <= '1';
		wait for CLK_period/2;
   end process;               
  stimulus: process
  begin
  
    -- Put initialisation code here
        tin <= '0';
		wait for 10 ns;
		tin <= '1';
		wait for 10 ns;
		tin <= '0';
		wait for 10 ns;
		tin <= '1';
		wait for 10 ns;

    -- Put test bench stimulus code here

   
  end process;

  

end;