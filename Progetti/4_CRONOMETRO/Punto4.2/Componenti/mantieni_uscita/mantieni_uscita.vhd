----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 18:52:51
-- Design Name: 
-- Module Name: mantieni_uscita - Behavioral
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

entity mantieni_uscita is
    Port ( a0 : in std_logic_vector(16 downto 0);
            a1 : in std_logic_vector(16 downto 0);
            a2 : in std_logic_vector(16 downto 0);
            a3 : in std_logic_vector(16 downto 0);
            a4 : in std_logic_vector(16 downto 0);
            click : in std_logic;
            clk : in std_logic;
            y_sec : out std_logic_vector(5 downto 0);
            y_min : out std_logic_vector(5 downto 0);
            y_ore : out std_logic_vector(4 downto 0)
        );
end mantieni_uscita;

architecture Behavioral of mantieni_uscita is
    signal uscita : std_logic_vector (16 downto 0);

begin
    intertempo : process(clk, uscita, a0, a1, a2, a3, a4)
    variable cont_visualizza : integer range 0 to 5 := 0;
    variable premuto_v : integer range 0 to 1 := 0;
    
    begin
    
    y_sec <= uscita (5 downto 0);
    y_min <= uscita (11 downto 6);
    y_ore <= uscita (16 downto 12);

    if(cont_visualizza = 0) then
        uscita <= a0;
    end if; 
     if(click='0' or click='U') then
        premuto_v :=0;
     end if; 
     if (not(rising_edge(clk)) and click = '1' and premuto_v=0) then
        premuto_v :=1;
        cont_visualizza := cont_visualizza +1;
        if (cont_visualizza = 1) then
            uscita <= a1;
        elsif (cont_visualizza = 2) then
            uscita <= a2;
        elsif (cont_visualizza = 3) then
            uscita <= a3;
        elsif (cont_visualizza = 4) then
            uscita <= a4;
        elsif (cont_visualizza = 5) then
            cont_visualizza := 0;   
        end if;
    end if; 
end process;

end Behavioral;
