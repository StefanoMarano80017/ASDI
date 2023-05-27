library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;
entity ContModN is
    generic(
        N:natural:=2
        
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC
           );
           
end ContModN;

architecture Behavioral of ContModN is

signal tmp : std_logic_vector (N downto 0) := (others => '0');
signal flag: std_logic := '0';

begin

counter <= tmp;
counter_process: process(clock)
begin
	if (clock'event AND clock = '1') then
	  if (reset = '1') then
		tmp <= (others => '0');
		flag<='0';
		stopCount<='0';
	  else
	   if (enable='1' and flag='0') then
	   if (tmp< "111") then
		tmp <= std_logic_vector(unsigned(tmp) + 1);
	   end if;
	   if (tmp >= "111") then
		flag<='1';
		stopCount<='1';
	   end if;
	  end if;
	  end if;
	end if;	
end process;

end Behavioral;

