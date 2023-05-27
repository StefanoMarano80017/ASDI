library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Registro_Rx is
   generic(N: natural:=3);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end Registro_Rx;

architecture Behavioral of Registro_Rx is
signal OutInternal: std_logic_vector(N downto 0);
begin
	RegistroRx: process(ClockRx, ResetRx, WriteRx,ReadRx)
		begin
		  if(ResetRx='1') then
			 OutInternal <= (others => '0');
		  elsif (ClockRx' event and ClockRx='1' ) then
			     if(WriteRx='1') then
				    OutInternal <= InRx;
				 end if;
			     if (ReadRx='1') then
				    OutRx<=OutInternal;
				   
			     end if;
		  end if;
	   end process;
	
end Behavioral;