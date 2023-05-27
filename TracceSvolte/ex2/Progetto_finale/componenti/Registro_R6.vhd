library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Registro_R6 is
   generic(N: natural:=6);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N-1 downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N-1 downto 0)
	);
end Registro_R6;

architecture Behavioral of Registro_R6 is
signal OutInternal: std_logic_vector(N-1 downto 0);
signal out_read : std_logic_vector(N-1 downto 0) := (others => '0');
begin
	RegistroRx: process(ClockRx, ResetRx, WriteRx,ReadRx)
		begin
		  if(ResetRx='1') then
			 OutInternal <= (others => '0');
		  elsif (ClockRx' event and ClockRx='0' ) then
			     if(WriteRx='1' and ReadRx='0') then
				    OutInternal <= InRx;
				 end if;
			     if (ReadRx='1' and WriteRx='0') then
				    out_read <= OutInternal;
			     	 end if;
			     if (ReadRx='0') then
				    out_read <= (others => '0');
			     	 end if;
		  end if;
	   end process;
		
	   OutRx <= out_read;
	
end Behavioral;