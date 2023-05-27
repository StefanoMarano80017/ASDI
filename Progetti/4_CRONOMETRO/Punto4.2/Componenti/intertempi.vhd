----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2022 17:26:30
-- Design Name: 
-- Module Name: cronometro_con_intertempi - Behavioral
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

entity intertempi is
    Port (  secondi : in std_logic_vector(5 downto 0);
            minuti : in std_logic_vector(5 downto 0);
            ore : in std_logic_vector(4 downto 0);
            clk : in std_logic;
            reset : in std_logic;
            stop : in std_logic;
            y1 : out std_logic_vector(16 downto 0);
            y2 : out std_logic_vector(16 downto 0);
            y3 : out std_logic_vector(16 downto 0);
            y4 : out std_logic_vector(16 downto 0)
          );
end intertempi;

architecture Behavioral of intertempi is
    
    signal int_1 : std_logic_vector (16 downto 0);
    signal int_2 : std_logic_vector (16 downto 0);
    signal int_3 : std_logic_vector (16 downto 0);
    signal int_4 : std_logic_vector (16 downto 0);

begin

    intertempo : process(clk, reset, int_1, int_2, int_3, int_4)
    variable cont_intertempi : integer range 0 to 3 := 0;
    variable premuto : integer range 0 to 1 := 0;
    begin
    y1 <= int_1;
    y2 <= int_2;
    y3 <= int_3;
    y4 <= int_4;
    
    if(stop='0' or stop='U') then
        premuto :=0;
    end if;
    
    if(reset = '1') then
        cont_intertempi := 0;
        int_1 <= "00000000000000000";
        int_2 <= "00000000000000000";
        int_3 <= "00000000000000000";
        int_4 <= "00000000000000000";
     
     elsif ( not(rising_edge(clk)) and stop='1' and premuto=0) then
        premuto :=1;
        if (cont_intertempi = 0) then
            int_1 (5 downto 0) <= secondi;  
            int_1 (11 downto 6) <= minuti;  
            int_1 (16 downto 12) <= ore; 
            cont_intertempi := cont_intertempi +1;
        elsif (cont_intertempi = 1) then
            int_2 (5 downto 0) <= secondi;  
            int_2 (11 downto 6) <= minuti;  
            int_2 (16 downto 12) <= ore; 
            cont_intertempi := cont_intertempi +1;
        elsif (cont_intertempi = 2) then
            int_3 (5 downto 0) <= secondi;  
            int_3 (11 downto 6) <= minuti;  
            int_3 (16 downto 12) <= ore; 
            cont_intertempi := cont_intertempi +1; 
        elsif (cont_intertempi = 3) then
            int_4 (5 downto 0) <= secondi;  
            int_4 (11 downto 6) <= minuti;  
            int_4 (16 downto 12) <= ore; 
            cont_intertempi := 0;    
        end if;
    end if;
    
end process;
        
end Behavioral;
