library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
entity ContModDmux is
    generic(
        N:natural:=1
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0)
           );
           
end ContModDmux;

architecture Behavioral of ContModDmux is

signal tmp : std_logic_vector (N downto 0) := (others => '0');

begin

counter_process: process(clock)
begin
	       if (reset = '1') then
				tmp <= (others => '0');
			elsif (clock'event and clock = '0' and enable= '1') then
				if (tmp = "11") then
					tmp <= (others => '0');
				else
					tmp <= std_logic_vector(unsigned(tmp) + 1);
					
				end if;
			end if;
	
	
end process;
counter <= tmp;
end Behavioral;
