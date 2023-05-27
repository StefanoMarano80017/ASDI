library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity ContRom is
    generic(N:integer:=3);
	port(
		Clk, Rst: in std_logic:='0';
		EnCont : in std_logic:='0';
		OutCont : out std_logic_vector (N downto 0):= (others => '0')
		);
end ContRom;

architecture Behavioral of ContRom is
	signal tmp : std_logic_vector (N downto 0):="0000";
	begin
		Conteggio : process (Clk, Rst, EnCont)
			begin
			if (Clk'event and Clk='1') then
				if (Rst = '1') then
					tmp <= "0000";
				end if;	
				if (EnCont = '1') then
					tmp <= std_logic_vector(unsigned(tmp) + 1);
				end if;
			end if;
		end process;
	OutCont <= tmp;
end Behavioral;