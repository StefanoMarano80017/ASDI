library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FlipFlopD_tb is
end;

architecture bench of FlipFlopD_tb is

  component FlipFlopD
  	port (
  		clk: in std_logic;
  		rst: in std_logic;
  		enble: in std_logic;
  		d: in std_logic;
  		q: out std_logic
  	);
  end component;

  signal CLK: std_logic;
  signal RST: std_logic;
  signal ENABLE: std_logic;
  signal Input: std_logic;
  signal Output: std_logic ;

  constant CLK_period: time := 10 ns;
 

begin

  uut: FlipFlopD port map ( clk => CLK,
                            rst => RST,
                            enble =>ENABLE,
                            d   => Input,
                            q   => Output );



    -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
  stimulus: process
  begin
  
    -- Put initialisation code here
        RST <= '1';
		Input <= '1';
		
		wait for 10 ns;
		ENABLE<='1';
		wait for 5ns;
		RST <= '0';
		Input <= '1';
		wait for 10ns;
		ENABLE<='0';
		wait for 20 ns;
       ENABLE<='1'; 
       RST <= '0';
		Input <= '0';
		
		
		wait for 20 ns; 
      
		Input <= '1';
		
		wait for 10 ns;


    -- Put test bench stimulus code here

    
    wait;
  end process;

  

end;
