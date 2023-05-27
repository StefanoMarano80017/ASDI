library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_21_gen is
    generic (
        N: natural:= 2
    );
    Port ( 
        a0, a1: in std_logic_vector(N-1 downto 0);
        s: in std_logic;
        y: out std_logic_vector(N-1 downto 0)
    );
end mux_21_gen;

architecture Behavioral of mux_21_gen is
begin
    
    y <= a0 when s = '0' else
         a1 when s = '1' else
         "--";

end Behavioral;
