library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Encoder_10_4_tb is
end;

architecture bench of Encoder_10_4_tb is

  component Encoder_10_4
      Port (
              a:in std_logic_vector(9 downto 0); 
              y:out std_logic_vector(3 downto 0)  
      );
  end component;

  signal Input: std_logic_vector(9 downto 0);
  signal Output: std_logic_vector(3 downto 0) ;

begin

  uut: Encoder_10_4 port map ( a => Input,
                               y => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
        wait for 3ns;
        Input <= "0000000000";
         wait for 3ns;
        Input <= "0000000001";
        wait for 3ns;
        Input <= "0000000010";
        wait for 3ns;
        Input <= "0000000100";
        wait for 3ns;
        Input <= "0000001000";
        wait for 3ns;
        Input <= "0001000000";
        wait for 3ns;
        Input <= "1000000000";
        wait for 3ns;
        Input <= "0000000000";
    -- Put test bench stimulus code here

    wait;
  end process;


end;