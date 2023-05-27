library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity encoder is
Port ( 
	y : in STD_LOGIC_VECTOR (7 downto 0);
	s : out STD_LOGIC_VECTOR (1 downto 0)
	
);
end encoder;

architecture Behavioral of encoder is
begin

	  s <="00" when y="00000000" else
          "11" when y="11000000";
end Behavioral;