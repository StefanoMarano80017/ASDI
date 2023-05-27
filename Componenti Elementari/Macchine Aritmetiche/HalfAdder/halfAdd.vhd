library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity halfAdd is
  Port ( 
        x,y :in std_logic;
        --s= somma e c= carry
        s,c :out std_logic
  );
end halfAdd;

architecture dataflow of halfAdd is

begin
    s<=x xor y;
    c <= x and y;


end dataflow;
