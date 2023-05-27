library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ContaBit is
 generic(N:integer:=7);
   port ( 
        a, b :IN std_logic_vector(N DOWNTO 0); -- data inputs
        y :out std_logic_vector(N DOWNTO 0)
         ); 
end ContaBit;

architecture structural of ContaBit is
component
Nxor is
 Port (IN1 : in  STD_LOGIC;
       IN2 : in  STD_LOGIC; 
       Yout : out  STD_LOGIC);
end component;

begin

Xnor0_N: FOR i IN 0 TO N GENERATE
CompXnor: Nxor PORT MAP( a(i), b(i),y(i) );

END GENERATE;

end structural;
