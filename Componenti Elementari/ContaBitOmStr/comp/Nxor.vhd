library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Nxor is
 Port (IN1 : in  STD_LOGIC;
       IN2 : in  STD_LOGIC; 
       Yout : out  STD_LOGIC);
end Nxor;

architecture dataflow of Nxor is

begin
Yout<=IN1 xnor IN2; 

end dataflow;
