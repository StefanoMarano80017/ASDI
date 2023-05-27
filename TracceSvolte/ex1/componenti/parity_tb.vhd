library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Parity_tb is
end;

architecture bench of Parity_tb is

  component Parity
  Port ( 
      Data: in std_logic_vector(3 downto 0);
      par:  in std_logic;
      out_par: out std_logic
  );
  end component;

  signal Data: std_logic_vector(3 downto 0);
  signal par: std_logic;
  signal out_par: std_logic ;

begin

  uut: Parity port map ( Data    => Data,
                         par     => par,
                         out_par => out_par );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Data <= "1010";
    par  <= '0';
    
    
    wait for 40ns;
    Data <= "1010";
    par  <= '1';

    -- Put test bench stimulus code here

    wait;
  end process;


end;
