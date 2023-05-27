library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Riconoscitore_tb is
end;

architecture bench of Riconoscitore_tb is

  component Riconoscitore
    Port ( 
          Clock : in std_logic;
          Reset : in std_logic;
          InDato : in std_logic;
          Modo : in std_logic;
          Y: out std_logic
    );
  end component;

  signal Clock: std_logic;
  signal Reset: std_logic;
  signal Input: std_logic;
  signal Modo: std_logic;
  signal Output: std_logic ;

  constant Clock_period: time := 10 ns;
  

begin

  uut: Riconoscitore port map ( Clock  => Clock,
                                Reset  => Reset,
                                InDato => Input,
                                Modo   => Modo,
                                Y      => Output );

   CLK_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
  
 
  
  
  stimulus: process
  begin
  wait for Clock_period*10;
    -- Put initialisation code here
    
    
   -- modo 1 sequenza corretta 1001
     Modo <='1';
    wait for 10 ns;
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
  
    
    Input <= '1';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
    
    -- modo 0 sequenza corretta 1001
    
    Modo <='0';
    wait for 10 ns;
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    
    Input <= '1';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
    
    -- modo 1 sequenza errata 111011
    
     Modo <='1';
    wait for 10 ns;
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    
    Input <= '1';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
    Input<= '1';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
    
    -- modo 1 sequenza corretta 100001
    
     Modo <='1';
    wait for 10 ns;
    Reset <= '1';
    wait for 10 ns;
    Reset <= '0';
    
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '0';
    wait for 10 ns;
    Input <= '1';
    wait for 10 ns;
  -- Put test bench stimulus code here

    
  end process;

  

end;
