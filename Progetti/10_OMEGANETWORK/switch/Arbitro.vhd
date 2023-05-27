library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Arbitro is
    Port ( 
        en0, en1, en2, en3: in std_logic;
        y: out std_logic_vector(1 downto 0)
    );
end Arbitro;

architecture Behavioral of Arbitro is
begin
    y <= "00" when en0 = '1' else
         "01" when en1 = '1' else
         "10" when en2 = '1' else
         "11" when en3 = '1' else
         "--";
end Behavioral;
