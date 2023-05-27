library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroValxB is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic:='0';
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic:='0';
		FlagX: out std_logic:='0'
	);
end RegistroValxB;

architecture Behavioral of RegistroValxB is
begin

Registro: process(ClockRx, ResetRx, WriteRx)
		begin
		if(ResetRx='1') then
			    
			     FlagX<='0';
		elsif (ClockRx' event and ClockRx='0' ) then
			     if(WriteRx='1'and InRx="01111111") then
				    FlagX<='1';
			     end if;    
		end if;
end process;
	
end Behavioral;