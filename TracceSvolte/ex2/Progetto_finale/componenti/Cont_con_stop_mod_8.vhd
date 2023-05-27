library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
entity Cont_con_stop_mod_8 is
    generic(
        N:natural:=3
        
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
	     enable : in STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (N-1 downto 0):= (others => '0');
           stopCount : out STD_LOGIC
           );
           
end Cont_con_stop_mod_8;

architecture Behavioral of Cont_con_stop_mod_8 is

signal tmp : std_logic_vector (N-1 downto 0) := (others => '0');
signal flag : std_logic := '0';

begin


counter_process: process(clock, reset, enable)
begin
	       if (reset = '1') then
				tmp <= (others => '0');
				flag <= '0';
				stopCount <= '0';
			elsif (clock'event and clock = '0' and enable= '1' and flag = '0') then
				if (tmp = "111") then
					stopCount <= '1';
					tmp <= (others => '0');
					flag <= '1';
				else
					tmp <= std_logic_vector(unsigned(tmp) + 1);
				end if;
			end if;
	
	
end process;
counter <= tmp;
stopCount <= flag;
end Behavioral;
