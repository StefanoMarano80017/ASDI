library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Encoder_8_3_tb is
end;

architecture bench of Encoder_8_3_tb is

  component Encoder_8_3
      Port (
              a:in std_logic_vector(7 downto 0); 
              y:out std_logic_vector(2 downto 0)  
      );
  end component;

  signal Input: std_logic_vector(7 downto 0);
  signal Output: std_logic_vector(2 downto 0) ;

begin

  uut: Encoder_8_3 port map ( a => Input,
                               y => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
        wait for 3ns;
        Input <= "00000000";
         wait for 3ns;
        Input <= "00000001";
        wait for 3ns;
        Input <= "00000010";
        wait for 3ns;
        Input <= "00000100";
        wait for 3ns;
        Input <= "00001000";
        wait for 3ns;
        Input <= "00010000";
        wait for 3ns;
        Input <= "00100000";
        wait for 3ns;
        Input <= "01000000";
        wait for 3ns;
        Input <= "10000000";
        wait for 3ns;
        Input <= "00000000";
        wait for 3ns;
        Input <= "11000000";
    -- Put test bench stimulus code here

    wait;
  end process;


end;