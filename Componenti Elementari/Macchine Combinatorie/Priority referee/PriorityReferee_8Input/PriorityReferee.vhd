library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity PriorityReferee is
  Port (
       Inx: in std_logic_vector(7 downto 0);
       Ux: out std_logic_vector(7 downto 0) 
  
  );
end PriorityReferee;
architecture Dataflow of PriorityReferee is

    begin
         Ux <=  "10000000" when Inx(7)='1' else
                "01000000" when Inx(6)='1' else
                "00100000" when Inx(5)='1' else
                "00010000" when Inx(4)='1' else
                "00001000" when Inx(3)='1' else
                "00000100" when Inx(2)='1' else
                "00000010" when Inx(1)='1' else
                "00000001" when Inx(0)='1' else
                "--------";


     end Dataflow;

