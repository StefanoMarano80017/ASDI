library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
	port (d, clk: IN std_logic:='0';
 	      q: OUT std_logic:='0');

end flipflop;

architecture Behavioral of flipflop is
signal qinternal: std_logic :='0';
begin
	process(clk)
	begin
		
		if (clk 'event and clk='1') then
			qinternal<=d;
		end if;
	end process;
	q<= qinternal;
end Behavioral;
