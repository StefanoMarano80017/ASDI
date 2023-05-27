library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FlipFlopD is
	port (
		clk, rst, enble, d: in std_logic;
		q: out std_logic
	);
end FlipFlopD;

architecture Behavioral of FlipFlopD is
signal qinternal: std_logic :='0';
begin
	process(clk, rst,enble)
	begin
	   if(enble='1')then
		 if(rst='1') then
			qinternal<='0';
		 elsif (clk 'event and clk='1') then
			qinternal<=d;
		end if;
	 end if;
	end process;
	q<= qinternal;
end Behavioral;

