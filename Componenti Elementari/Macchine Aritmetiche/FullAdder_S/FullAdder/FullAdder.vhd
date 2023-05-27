library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
  Port ( 
        a,b,c_in :in std_logic;
        s,c_out :out std_logic
  );
end FullAdder;

architecture Structural of FullAdder is
    component halfAdd is
        Port ( 
            x,y :in std_logic;
            --s= somma e c= carry
            s,c :out std_logic
        );
    end component;
    signal s0 : STD_LOGIC := '0';
    signal c0 : STD_LOGIC := '0';
    signal s1 : STD_LOGIC := '0';
    signal c1 : STD_LOGIC := '0';
begin
    halfAdd0: halfAdd
    Port map(
        x =>a,
        y =>b,
        s =>s0,
        c =>c0
    );
    halfAdd1: halfAdd
    Port map(
        x =>s0,
        y =>c_in,
        s =>s1,
        c =>c1
    );
    s<=s1;
    c_out <= c0 or c1;
    
end Structural;
