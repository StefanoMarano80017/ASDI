--CONTATORE MODN seriale

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ContModN is
  Generic(
    N:integer:=3
  );
  Port (
        Clk : in std_logic;
        Rst :in std_logic;
        Cont : out std_logic_vector(N-1 downto 0) 
    
 );
end ContModN;

architecture rtl of ContModN is
    component FlipFlopT is
            Port ( 
                clk :in std_logic;
                rst :in std_logic;
                y :out std_logic
            );
    end component;
    Signal Sx: std_logic_vector(N-1 downto 0);
    begin
        ff1: flipflopT
          port map(
            Clk,
            Rst,
            Sx(0) 
          );
         FF: for i in 1 to N-1 generate
            FFTx: FlipFlopT
               port map(
                    Sx(i-1),
                    Rst,
                    Sx(i) 
               );
       end generate;
         
          Cont <= Sx;
end rtl;









