library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
entity Cont_mod_9 is
    generic(
        N:natural:=4
        
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
	     enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (N-1 downto 0):= (others => '0')
           );
           
end Cont_mod_9;

architecture Behavioral of Cont_mod_9 is

signal tmp : std_logic_vector (N-1 downto 0) := (others => '0');

begin


counter_process: process(clock, reset, enable)
begin
	       if (reset = '1') then
				tmp <= (others => '0');
			elsif (clock'event and clock = '0' and enable= '1') then
				if (tmp = "1000") then
					tmp <= (others => '0');
				else
					tmp <= std_logic_vector(unsigned(tmp) + 1);
				end if;
			end if;
	
	
end process;
counter <= tmp;
end Behavioral;
