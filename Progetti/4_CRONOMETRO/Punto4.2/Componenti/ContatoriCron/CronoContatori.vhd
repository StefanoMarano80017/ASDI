library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CronoContatori is  
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
end CronoContatori;

architecture structural of CronoContatori is
    
    
    
    signal rstMnt : std_logic;
    signal rstOre : std_logic;
    signal Stop: std_logic;
    Signal Y0: std_logic;
    Signal Y1: std_logic;
    Signal Y2: std_logic;
    
    component ContMod24 is
        Port (
            
            Clk : in std_logic;
            Rst :in std_logic;
            set :in std_logic;
            setVal : in std_logic_vector(4 downto 0);
            Cont : out std_logic_vector(4 downto 0);
            Cont23 : inout std_logic
    
        );
    end component;
    
    component ContMod60
        Port (
             Clk : in std_logic;
             Rst :in std_logic;
             set :in std_logic;
             setVal : in std_logic_vector(5 downto 0);
             Cont : inout std_logic_vector(5 downto 0);
             Cont59 : inout std_logic  
   );
    end component;
begin
Y0 <= Clock and (not(rstMnt) or not(rstOre) or not(stop));    

ContSecondi: ContMod60 
      Port map(
      Y0 ,
            Rst,
            set,
            SetSec,
            TimerSec,
            rstMnt
      );
Y1 <= (Clock and rstMnt)and (not(rstOre) or not(Stop));      
ContMinuti: ContMod60 
      Port map(
      Y1 ,
            Rst,
            set,
            SetMinuti,
            TimerMinuti,
            rstOre
      );
Y2 <= (Clock and rstMnt and rstOre) and not(Stop);        
ContOre: ContMod24 
      Port map(
      Y2 ,
            Rst,
            set,
            SetOre,
            TimerOre,
            Stop
      );

end structural;

