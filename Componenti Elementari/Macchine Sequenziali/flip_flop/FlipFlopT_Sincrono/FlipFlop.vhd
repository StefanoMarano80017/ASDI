


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity FlipFlopT is
 Port ( 
        clock : in STD_LOGIC;
        tin : in STD_LOGIC;
        q : out STD_LOGIC
 
 
 );
end FlipFlopT;

architecture Behavioral of FlipFlopT is
        signal qinternal : std_logic := '0';
        begin
            fft : process(clock, tin)
            begin
                if (clock'event and clock='1') then
                if (tin = '0') then
                    qinternal <=qinternal;
                elsif (tin = '1') then
                     qinternal <=not qinternal;
                end if;
                end if;
                end process;
       q <=qinternal;
            


end Behavioral;
