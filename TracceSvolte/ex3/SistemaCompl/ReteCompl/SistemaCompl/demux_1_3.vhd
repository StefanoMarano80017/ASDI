library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity demux_1_3 is
   generic( N:integer:=7);
    Port ( 
	   x : in STD_LOGIC_VECTOR(N downto 0);
	   s : in STD_LOGIC_VECTOR(1 downto 0);
           y0 : out STD_LOGIC_VECTOR(N downto 0);
           y1 : out STD_LOGIC_VECTOR(N downto 0);
	   y2 : out STD_LOGIC_VECTOR(N downto 0)
           );
end demux_1_3;

architecture Dataflow of demux_1_3 is

begin
   y0 <= x when s = "00" else "00000000";
   y1 <= x when s = "01" else "00000000";
   y2 <= x when s = "10" else "00000000";


end Dataflow;


