
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_41_gen is 
    generic (
        N: natural:= 2; --dimensione dati
        M: natural:= 2 --dimensione indirizzi
    );
    Port ( 
        a0,a1,a2,a3: in std_logic_vector(N-1 downto 0);
        s: in std_logic_vector(M-1 downto 0);
        y: out std_logic_vector(N-1 downto 0)
    );
end mux_41_gen;

architecture Behavioral of mux_41_gen is
begin

    y <= a0 when s="00" else
         a1 when s="01" else
         a2 when s="10" else
         a3 when s="11" else
         "--"; 

end Behavioral;
