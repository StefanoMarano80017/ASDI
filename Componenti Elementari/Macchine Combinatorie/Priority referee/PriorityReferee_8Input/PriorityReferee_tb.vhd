library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity PriorityReferee_tb is
end;

architecture bench of PriorityReferee_tb is

  component PriorityReferee
    Port (
         Inx: in std_logic_vector(0 to 7);
         Ux: out std_logic_vector(0 to 7) 
    );
  end component;

  signal Input: std_logic_vector(0 to 7);
  signal Output: std_logic_vector(0 to 7) ;

begin

  uut: PriorityReferee port map ( Inx => Input,
                                  Ux  => Output );

  stimulus: process
  begin
  
    -- Put initialisation code here
       wait for 4ns;
       Input <="00000001";
        wait for 4ns;
       Input <="00000010";
        wait for 4ns;
       Input <="00000100";
        wait for 4ns;
       Input <="00000000";
    

    -- Put test bench stimulus code here

    wait;
  end process;


end;