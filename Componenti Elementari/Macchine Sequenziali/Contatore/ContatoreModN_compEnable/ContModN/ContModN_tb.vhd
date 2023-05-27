library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity ContModN_tb is
end;

architecture bench of ContModN_tb is
 
  component ContModN
      Port ( clock : in  STD_LOGIC;
             reset : in  STD_LOGIC;
  		      enable : in STD_LOGIC;
             counter : out  STD_LOGIC_VECTOR (2 downto 0));
  end component;

  signal Clock: STD_LOGIC;
  signal Reset: STD_LOGIC;
  signal Enable: STD_LOGIC;
  signal Count: STD_LOGIC_VECTOR (2 downto 0);

  constant CLK_period: time := 10 ns;
  

begin

  uut: ContModN port map ( clock   => Clock,
                           reset   => Reset,
                           enable  => Enable,
                           counter => Count );


  CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock  <= '1';
		wait for CLK_period/2;
   end process;

  stimulus: process
  begin
  
    -- Put initialisation code here
    Enable<='1';

    -- Put test bench stimulus code here

   
    wait;
  end process;

 

end;