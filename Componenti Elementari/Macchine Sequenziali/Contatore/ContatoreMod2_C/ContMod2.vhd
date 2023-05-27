

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ContMod2 is
	port(
		clk, rst: in std_logic;
		OutC : out std_logic

		);
end ContMod2;
architecture rtl of ContMod2 is
	signal tmpOut : std_logic;
	begin
		count : process (clk, rst)
			     begin
			     if (clk'event and clk = '1') then
				     if (rst = '1') then
					   tmpOut <= '0';
				     else
				     
					   tmpOut <= std_logic(integer(tmpOut) + 1);
				    end if;
			     end if;
		 end process;
	     OutC <= tmpOut;
	
end rtl;
