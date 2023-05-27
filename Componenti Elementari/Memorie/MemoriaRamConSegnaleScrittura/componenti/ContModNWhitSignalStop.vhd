library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
entity ContModN is
    generic(
        N:natural:=3
        
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC :='0'
           );
           
end ContModN;

architecture Behavioral of ContModN is

signal tmp : std_logic_vector (N downto 0) := (others => '0');

begin


counter_process: process(clock)
begin
	       if (reset = '1') then
				tmp <= (others => '0');
			elsif (clock'event and clock = '0' and enable= '1') then
				if (tmp = "0111") then
					stopCount <= '1';
					tmp <= (others => '0');
				else
					tmp <= std_logic_vector(unsigned(tmp) + 1);
					stopCount <= '0';
				end if;
			end if;
	
	
end process;
counter <= tmp;
end Behavioral;
