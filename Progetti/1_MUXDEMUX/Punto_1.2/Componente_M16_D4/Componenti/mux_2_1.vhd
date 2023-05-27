library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_2_1 is
    Port ( a0 : in STD_LOGIC;
           a1 : in STD_LOGIC;
           s : in STD_LOGIC;
           y : out STD_LOGIC);
end mux_2_1;

architecture Dataflow of mux_2_1 is

begin
    y 	<= 	a0 when s = '0' else	
		    a1 when s = '1' else
		    '-';


end Dataflow;
