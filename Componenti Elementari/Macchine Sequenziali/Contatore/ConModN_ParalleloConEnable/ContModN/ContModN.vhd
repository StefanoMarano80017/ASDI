--CONTATORE MODN parallelo

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ContModN is
  Generic(
    N:integer:=3
  );
  Port (
        Clk : in std_logic;
        Rst :in std_logic;
        Enable :in std_logic;
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
    Signal Yx: std_logic_vector(N-1 downto 0);
    begin
        ff1: flipflopT
          port map(
            Clk and Enable,
            Rst,
            Sx(0) 
          );
          Yx(0) <= Sx(0) and Clk;
         FF: for i in 1 to N-1 generate
            FFTx: FlipFlopT
               port map(
                    Yx(i-1),
                    Rst,
                    Sx(i) 
               );
               Yx(i)<= Yx(i-1) and Sx(i) and  Clk;
       end generate;
         
          Cont <= Sx;
end rtl;

