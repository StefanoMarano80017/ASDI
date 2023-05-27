library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Mux_2_1 is
    generic(
        N:natural:=7
    );
    Port ( a0 : in std_logic_vector(N downto 0);
           a1 : in std_logic_vector(N downto 0);
           s : in STD_LOGIC;
           y : out std_logic_vector(N downto 0));
end Mux_2_1;

architecture Dataflow of Mux_2_1 is

begin
    y 	<= 	a0 when s = '0' else	
		    a1 when s = '1' else
		    "--------";


end Dataflow;