library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ShiftRegRing is
    port(
        clk, load: IN std_logic:='0';
        d: IN std_logic_vector(0 TO 3);
        q: inout std_logic_vector(0 TO 3);
        qout : out std_logic:='0');
 
end ShiftRegRing;

architecture strucutural of ShiftRegRing is
SIGNAL i: std_logic_vector(0 TO 3);
component flipflop is
	port (d, clk: IN std_logic:='0';
 	      q: OUT std_logic:='0');

end component;

component mux IS
port (a, b, sel: IN std_logic:='0';
      x: OUT std_logic:='0');
end component; 

begin
 mux1: mux PORT MAP (q(3), d(0), load, i(0));
 mux2: mux PORT MAP (q(0), d(1), load, i(1));
 mux3: mux PORT MAP (q(1), d(2), load, i(2));
 mux4: mux PORT MAP (q(2), d(3), load, i(3));
 dff1: flipflop PORT MAP (i(0), clk, q(0));
 dff2: flipflop PORT MAP (i(1), clk, q(1));
 dff3: flipflop PORT MAP (i(2), clk, q(2));
 dff4: flipflop PORT MAP (i(3), clk, q(3));
 qout<=q(0);

end strucutural;
