--CONTATORE MOD60 Parallelo

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ContMod60 is
  Port (
        Clk : in std_logic;
        Rst :in std_logic;
        set :in std_logic;
        setVal : in std_logic_vector(5 downto 0);
        Cont : inout std_logic_vector(5 downto 0);
        Cont59 : inout std_logic 
    
 );
end ContMod60;

architecture Structural of ContMod60 is
    component FlipFlopT is
            Port ( 
                clk :in std_logic;
                rst :in std_logic;
                set :in std_logic;
                setVal :in std_logic;
                y :out std_logic
            );
    end component;
    Signal S1: std_logic;
    Signal S2: std_logic;
    Signal S3: std_logic;
    Signal S4: std_logic;
    Signal S5: std_logic;
    Signal S6: std_logic;
    
    Signal Y1: std_logic;
    Signal Y2: std_logic;
    Signal Y3: std_logic;
    Signal Y4: std_logic;
    Signal Y5: std_logic;
    Signal Y6: std_logic;
    
    
    
    Signal rstInt: std_logic;
    Signal setInt: std_logic;
    Signal Cont60 : std_logic;
    

    begin
         rstInt <= Rst or Cont60 or (setInt and set) ;
         ff1: flipflopT
          port map(
            Clk ,
            rstInt,
            set,
            setVal(0),
            S1 
          );
          
          Y1 <= S1 and Clk;
          ff2: flipflopT
          port map(
            Y1 ,
            rstInt,
            set,
            setVal(1),
            S2 
          );
         
          Y2 <= S2 and S1 and Clk;
          ff3: flipflopT
          port map(
             Y2,
             rstInt,
             set,
            setVal(2),
             S3
          );
         Y3 <=S3 and S2 and S1 and Clk;
          ff4: flipflopT
          port map(
             Y3,
             rstInt,
             set,
             setVal(3),
             S4
          );
          Y4 <=S4 and S3 and S2 and S1 and Clk;
          ff5: flipflopT
          port map(
             Y4,
             rstInt,
             set,
             setVal(4),
             S5
          );
          Y5 <=S5 and S4 and S3 and S2 and S1 and Clk;
          ff6: flipflopT
          port map(
             Y5,
             rstInt,
             set,
             setVal(5),
             S6
          );
          Cont60 <= S6  and S5 and S4 and S3 and not(S2) and  not(S1);
          setInt <= setVal(5) and setVal(4) and setVal(3) and setVal(2);
          Cont59 <= S6  and S5 and S4 and not(S3) and S2 and  S1;
          Cont <= S6 & S5 &S4 & S3 & S2 &  S1;



end Structural;
