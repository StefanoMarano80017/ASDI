library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PriorityEncoder_tb is
end;

architecture bench of PriorityEncoder_tb is

  component PriorityEncoder
    Port ( 
          InBcd: in std_logic_vector( 9 downto 0);
          OutBcd: out std_logic_vector( 3 downto 0)
    );
  end component;

  signal Input: std_logic_vector( 9 downto 0);
  signal Output: std_logic_vector( 3 downto 0) ;

begin

  uut: PriorityEncoder port map ( InBcd  => Input,
                                  OutBcd => Output );

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
       Input <= "0000010000";
       wait for 3ns;
       Input <= "0000100000";
       wait for 3ns;
       Input <= "0001000000";
       wait for 3ns;
       Input <= "0010000000";
       wait for 3ns;
       Input <= "0100000000";
       wait for 3ns;
       Input <= "1000000000";
       wait for 3ns;
       Input <= "0000000000";

    -- Put test bench stimulus code here

    wait;
  end process;


end;