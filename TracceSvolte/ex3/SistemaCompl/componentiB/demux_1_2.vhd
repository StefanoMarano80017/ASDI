library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity demux_1_2 is
   generic( N:integer:=7);
    Port ( 
	   x : in STD_LOGIC_VECTOR(N downto 0);
	   s : in STD_LOGIC;
           y0 : out STD_LOGIC_VECTOR(N downto 0);
           y1 : out STD_LOGIC_VECTOR(N downto 0)
           );
end demux_1_2;

architecture Dataflow of demux_1_2 is

begin
   y0 <= x when s = '0' else "00000000";
   y1 <= x when s = '1' else "00000000";


end Dataflow;


