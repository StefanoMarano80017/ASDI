library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Encoder_10_4 is
    Port (
            a:in std_logic_vector(9 downto 0); 
            y:out std_logic_vector(3 downto 0)  
    );
end Encoder_10_4;

architecture Dataflow of Encoder_10_4 is

begin
        y <= "0000" when a="0000000001" else
             "0001" when a="0000000010" else
             "0010" when a="0000000100" else
             "0011" when a="0000001000" else
             "0100" when a="0000010000" else
             "0101" when a="0000100000" else
             "0110" when a="0001000000" else
             "0111" when a="0010000000" else
             "1000" when a="0100000000" else
             "1001" when a="1000000000" else
             "----";
end Dataflow;
