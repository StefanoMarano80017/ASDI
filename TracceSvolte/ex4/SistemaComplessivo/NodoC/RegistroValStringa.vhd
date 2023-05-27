library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroValStringa is
   generic(N: natural:=3);
	port(
		ClockRx: in std_logic;
		WriteRx: in std_logic;
		FlagStringa: out std_logic:='0';
		InRx: in string(1 to 3)
	);
end RegistroValStringa;

architecture Behavioral of RegistroValStringa is

signal OutInternal: string(1 to 3):="000" ;

begin

Registro: process(ClockRx,WriteRx)
		begin
		if (ClockRx' event and ClockRx='0' ) then
			     if(WriteRx ='1' and InRx="$ff") then
				   OutInternal<=InRx;
			           FlagStringa<='1';
			     end if;    
		end if;
end process;
	
end Behavioral;