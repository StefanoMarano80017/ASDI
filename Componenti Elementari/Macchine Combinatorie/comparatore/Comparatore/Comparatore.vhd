library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparatore is
   generic(N:integer:=7);
    Port ( a, b : in  std_logic_vector(N downto 0);
           greater : out  STD_LOGIC);
end comparatore;

architecture Behavioral of comparatore is
begin
    greater <= '0' when a > b else '1';
end Behavioral;
