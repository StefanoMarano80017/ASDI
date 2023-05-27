library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux IS
port (a : IN std_logic:='0';
      b: IN std_logic:='0';
      sel: IN std_logic:='0';
      x: OUT std_logic:='0');
END mux;

architecture Dataflow of mux is

begin
    x <= a WHEN sel='0' ELSE b;

end Dataflow;
