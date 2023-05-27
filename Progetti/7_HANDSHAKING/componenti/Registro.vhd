library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro is
   generic(N: natural:=3);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end Registro;

architecture Behavioral of Registro is

signal OutInternal: std_logic_vector(N downto 0):= "0000";

begin

Registro: process(ClockRx, ResetRx, WriteRx,ReadRx)
		begin
		if(ResetRx='1') then
			     OutInternal <= (others => '0');
		elsif (ClockRx' event and ClockRx='0' ) then
			     if(WriteRx='1' and ReadRx ='0' ) then
				    OutInternal <= InRx;
			     elsif (WriteRx = '0' and ReadRx='1') then
				    OutRx<=OutInternal;
			     end if;    
		end if;
end process;
	
end Behavioral;