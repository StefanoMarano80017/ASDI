library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroValx is
   generic(N: natural:=7);
	port(
		ClockRx: in std_logic;
		ReadRx: in std_logic;
		OutToCmp: out std_logic_vector(N downto 0);
		OutRx: out std_logic_vector(N downto 0)
	);
end RegistroValx;

architecture Behavioral of RegistroValx is

signal OutInternal: std_logic_vector(N downto 0):= "01111111";

begin

Registro: process(ClockRx,ReadRx)
		begin
		if (ClockRx' event and ClockRx='0' ) then
		        OutToCmp<=OutInternal;
			     if(ReadRx ='1' ) then
				    OutRx<=OutInternal;
			     end if;    
		end if;
end process;
	
end Behavioral;