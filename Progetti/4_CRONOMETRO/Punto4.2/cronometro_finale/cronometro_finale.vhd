----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.11.2022 11:28:46
-- Design Name: 
-- Module Name: cronometro_finale - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronometro_finale is
    Port ( Clock : in std_logic;
            Rst : in std_logic;
            Set : in std_logic;
            Click_visualizzazione : in std_logic;   --pulsante per cambiare le modalità di visualizzazione del display
            Stop_intertempo : in std_logic; --pulsante per salvare un intertempo
            SetOre : in std_logic_vector(4 downto 0);
            SetMinuti : in std_logic_vector(5 downto 0);
            SetSec : in std_logic_vector(5 downto 0);
            TimerOre : inout std_logic_vector(4 downto 0);
            TimerMinuti : inout std_logic_vector(5 downto 0);
            TimerSec : inout std_logic_vector(5 downto 0)
         );
end cronometro_finale;

architecture Structural of cronometro_finale is

    signal tempo_corrente : std_logic_vector(16 downto 0);
    signal intertempo_1 : std_logic_vector(16 downto 0);
    signal intertempo_2 : std_logic_vector(16 downto 0);
    signal intertempo_3 : std_logic_vector(16 downto 0);
    signal intertempo_4 : std_logic_vector(16 downto 0);
    signal u_sec : std_logic_vector(5 downto 0);
    signal u_min : std_logic_vector(5 downto 0);
    signal u_ore : std_logic_vector(4 downto 0);
    
    component CronoContatori is
        Port (
            
            Clock : in std_logic;
            Rst :in std_logic;
            Set :in std_logic;
            SetOre : in std_logic_vector(4 downto 0);
            SetMinuti : in std_logic_vector(5 downto 0);
            SetSec : in std_logic_vector(5 downto 0);
            TimerOre : inout std_logic_vector(4 downto 0);
            TimerMinuti : inout std_logic_vector(5 downto 0);
            TimerSec : inout std_logic_vector(5 downto 0)  
    
        );
    end component;
    
    component intertempi
    Port (
            secondi : in std_logic_vector(5 downto 0);
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
    end component;
    
    component mantieni_uscita
    Port (
            a0 : in std_logic_vector(16 downto 0);
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
    end component;

begin

Blocco_cronometro : CronoContatori
    Port map(
      Clock,
      Rst,
      Set,
      SetOre,
      SetMinuti,
      SetSec,
      u_ore,
      u_min,
      u_sec
      );


Blocco_intertempo : intertempi
    Port map(
      u_sec,
      u_min,
      u_ore,
            Clock,
            Rst,
            Stop_intertempo,
            intertempo_1,
            intertempo_2,
            intertempo_3,
            intertempo_4
      );
      
tempo_corrente <= u_ore & u_min & u_sec;

Blocco_manitieni_uscita: mantieni_uscita
    Port map(
      tempo_corrente,
            intertempo_1,
            intertempo_2,
            intertempo_3,
            intertempo_4,
            Click_visualizzazione,
            Clock,
            TimerSec,
            TimerMinuti,
            TimerOre
            
      );


end Structural;
