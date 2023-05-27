library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Registro is
   generic(N: natural:=8);
	port(
	   InReg: in std_logic_vector(N-1 downto 0);
		ClockR, ResetR, EnableR: in std_logic;
		OutR: out std_logic_vector(N-1 downto 0)
	);
end Registro;

architecture Behavioral of registro is
signal OutInternal: std_logic_vector(N-1 downto 0);
begin
	RegistroN: process(ClockR, ResetR, EnableR)
		begin
		if(EnableR='1') then
			if(ResetR='1') then
				OutInternal <= (others => '0');
			elsif (ClockR' event and ClockR='1') then
				OutInternal <= InReg;
			end if;
		end if;
	end process;
	OutR<=OutInternal;
end Behavioral;