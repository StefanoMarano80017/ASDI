----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.01.2023 09:50:44
-- Design Name: 
-- Module Name: comparatore - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparatoreB is
    generic(N:natural:=8);
    Port (
        input_1 : in std_logic:='0';
        input_2 : in std_logic:='0';
        output : out std_logic:='0' --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end comparatoreB;

architecture behavioral  of comparatoreB is
    
    
begin
    
process(input_1, input_2)
begin
    
    if((input_1='1' and input_2='1')) then
       output <= '1';
    else
        output <= '0';
    end if;    
    
end process;

 
 

end ;
