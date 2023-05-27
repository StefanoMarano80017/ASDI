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

entity comparatore is
    generic(N:natural:=6);
    Port (
        input_1 : in std_logic_vector(N-1 downto 0);
        input_2 : in std_logic_vector(N-1 downto 0);
        output_uguali : out std_logic --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end comparatore;

architecture behavioral  of comparatore is
    
    
begin
    
process(input_1, input_2)
begin
    
    if(TO_INTEGER(signed(input_1)) = TO_INTEGER(signed(input_2))) then
       output_uguali <= '1';
    else
        output_uguali <= '0';
    end if;
    
    
end process;

 
 

end ;
