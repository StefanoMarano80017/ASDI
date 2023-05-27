--CONTATORE MOD60 seriale

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ContMod60 is
  Port (
        Clk : in std_logic;
        Rst :in std_logic;
        Cont : out std_logic_vector(0 to 5) 
    
 );
end ContMod60;

architecture Structural of ContMod60 is
    component FlipFlopT is
            Port ( 
                clk :in std_logic;
                rst :in std_logic;
                y :out std_logic
            );
    end component;
    Signal S1: std_logic;
    Signal S2: std_logic;
    Signal S3: std_logic;
    Signal S4: std_logic;
    Signal S5: std_logic;
    Signal S6: std_logic;
    Signal rstInt: std_logic;
    Signal Cont60 : std_logic;
    

    begin
         rstInt <= Rst or Cont60;
         ff1: flipflopT
          port map(
            Clk ,
            rstInt,
            S1 
          );
          
          
          ff2: flipflopT
          port map(
            S1,
            rstInt,
            S2 
          );
         
          
          ff3: flipflopT
          port map(
             S2,
             rstInt,
             S3
          );
      
          ff4: flipflopT
          port map(
             S3,
             rstInt,
             S4
          );
          
          ff5: flipflopT
          port map(
             S4,
             rstInt,
             S5
          );
          ff6: flipflopT
          port map(
             S5,
             rstInt,
             S6
          );
          Cont60 <= S6  and S5 and S4 and S3 and not(S2) and  not(S1);
          Cont <= S6 & S5 &S4 & S3 & S2 &  S1;



end Structural;
