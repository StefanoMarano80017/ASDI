library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop is
	port (
	      d  : IN std_logic:='0';
	      preload : IN std_logic:='0';
	      En : IN std_logic:='0';
 	      clk  : IN std_logic:='0';
 	      q: OUT std_logic:='0');

end flipflop;

architecture Behavioral of flipflop is
signal qinternal: std_logic :='0';
begin
	process(clk)
	begin
		if (preload = '1') then
            qinternal <= d;
		elsif (clk 'event and clk='1' and En='1') then
			qinternal<=d;
		end if;
	end process;
	q<= qinternal;
end Behavioral;
