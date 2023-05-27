----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.11.2022 17:22:50
-- Design Name: 
-- Module Name: demux_41_gen - Behavioral
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

entity demux_41_gen is
    generic(
        N: natural:= 2;
        M: natural:= 2
    );
    Port ( 
        a0: in std_logic_vector(N-1 downto 0);
        s:  in std_logic_vector(M-1 downto 0);
        y0, y1, y2, y3: out std_logic_vector(N-1 downto 0)   
    );
end demux_41_gen;

architecture Behavioral of demux_41_gen is

begin
        y0 <= a0 when s = "00" else "--";
        y1 <= a0 when s = "01" else "--";
        y2 <= a0 when s = "10" else "--";
        y3 <= a0 when s = "11" else "--";

end Behavioral;
