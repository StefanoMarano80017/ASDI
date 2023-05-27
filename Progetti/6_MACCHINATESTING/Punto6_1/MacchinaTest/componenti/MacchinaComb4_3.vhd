library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MacchinaComb4_3 is
  Port ( 
        x: in std_logic_vector(3 downto 0);
        y: out std_logic_vector(2 downto 0)
  );
end MacchinaComb4_3;

architecture dataflow of MacchinaComb4_3 is
begin
y <= "000"      when x="0000"
     else "001" when x="0001"
     else "010" when x="0010"
     else "011" when x="0011"
     else "100" when x="0100"
     else "101" when x="0101"
     else "110" when x="0110"
     else "111" when x="0111"
     else "000" when x="1000"
     else "001" when x="1001"
     else "010" when x="1010"
     else "011" when x="1011"
     else "100" when x="1100"
     else "101" when x="1101"
     else "110" when x="1110"
     else "111" when x="1111";
end dataflow;
