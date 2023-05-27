library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroValCost is
   generic(N: natural:=3);
	port(
		ClockRx: in std_logic;
		ReadRx: in std_logic;
		--OutToCmp: out std_logic_vector(N downto 0);
		OutRx: out string(1 to 3)
	);
end RegistroValCost;

architecture Behavioral of RegistroValCost is

signal OutInternal: string(1 to 3) := "$00";

begin

Registro: process(ClockRx,ReadRx)
		begin
		if (ClockRx' event and ClockRx='0' ) then
		        --OutToCmp<=OutInternal;
			     if(ReadRx ='1' ) then
				   OutRx<=OutInternal;
			     end if;    
		end if;
end process;
	
end Behavioral;