library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_12_gen is
    generic(
        N: natural:= 2
    );
    Port ( 
        y: in std_logic_vector(N downto 0);
        s: in std_logic;
        a0, a1: out std_logic_vector(N downto 0)
    );
end demux_12_gen;

architecture Behavioral of demux_12_gen is
begin

       a0 <= y when s = '0' else (others => '-');
       a1 <= y when s = '1' else (others => '-');

end Behavioral;
