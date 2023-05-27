library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity comparatore is
    generic(N:natural:=4);
    Port (
        input_1 : in std_logic_vector(N-1 downto 0);
        input_2 : in std_logic_vector(N-1 downto 0);
        output : out std_logic --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end comparatore;

architecture behavioral  of comparatore is
begin
    
process(input_1, input_2)
begin
    
    if(TO_INTEGER(signed(input_1)) = TO_INTEGER(signed(input_2))) then
       output <= '1';
    else
        output <= '0';
    end if;    
    
end process;

end ;