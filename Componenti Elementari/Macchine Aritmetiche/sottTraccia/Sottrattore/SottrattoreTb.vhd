
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Sottrattore_tb is
end;

architecture bench of Sottrattore_tb is

  component Sottrattore
  	generic(N:integer:=0);
  	port(
  		a,b : in std_logic:='0';
  		cin : in std_logic:='0';
  		s,cout : out std_logic:='0'
  	);
  end component;

  signal a,b: std_logic;
  signal cin: std_logic;
  signal s,cout: std_logic ;

begin

  -- Insert values for generic parameters !!
  uut: Sottrattore generic map ( N    =>0  )
                      port map ( a    => a,
                                 b    => b,
                                 cin  => cin,
                                 s    => s,
                                 cout => cout );

  stimulus: process
  begin
  
    -- Put initialisation code here
a<='0';
b<='1';
cin<='0';
    
    -- Put test bench stimulus code here

    wait;
  end process;


end;
  