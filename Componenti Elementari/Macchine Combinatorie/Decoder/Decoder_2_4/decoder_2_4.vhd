library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity demux_2_4 is
  port ( 
  a: in std_logic_vector( 0 to 1);
  enable: in std_logic;
  u: out std_logic_vector( 0 to 3)
  );
end demux_2_4;
architecture Behavioral of demux_2_4 is
    begin
        u <= "0000" when enable='1' and a="00" else
             "0010" when enable='1' and a="01" else
             "0100" when enable='1' and a="10" else
             "1000" when enable='1' and a="11" else
             "0000";
end Behavioral;
