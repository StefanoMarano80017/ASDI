library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegistroB is
   generic(N: natural:=7);
	port(
		ClockRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end RegistroB;

architecture Behavioral of RegistroB is

signal OutInternal: std_logic_vector(N downto 0):= "00000000";

begin

Registro: process(ClockRx,WriteRx,ReadRx)
		begin
		
		if (ClockRx' event and ClockRx='0' ) then
			     if(WriteRx='1' and ReadRx ='0' ) then
				    OutInternal <= InRx;
			     elsif (WriteRx = '0' and ReadRx='1') then
				    OutRx<=OutInternal;
			     end if;    
		end if;
end process;
	
end Behavioral;