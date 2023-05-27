library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PriorityReferee is
  Port (
       Inx: in std_logic_vector(9 downto 0);
       Ux: out std_logic_vector(9 downto 0) 
  
  );
end PriorityReferee;
architecture Behavioral of PriorityReferee is

    begin
         Ux <=  "1000000000" when Inx(9)='1' else
                "0100000000" when Inx(8)='1' else
                "0010000000" when Inx(7)='1' else
                "0001000000" when Inx(6)='1' else
                "0000100000" when Inx(5)='1' else
                "0000010000" when Inx(4)='1' else
                "0000001000" when Inx(3)='1' else
                "0000000100" when Inx(2)='1' else
                "0000000010" when Inx(1)='1' else
                "0000000001" when Inx(0)='1' else
                "----------";


     end Behavioral;
