library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity Addizionatore is
	generic(N:integer:=7);
	port(
		A : in std_logic_vector(N downto 0):="00000000";
		B : in std_logic_vector(N downto 0):="00000000";
		S : out std_logic_vector(N downto 0):="00000000"
	);
end Addizionatore;

architecture Behavioral of Addizionatore is
begin
    Somma:process(A,B)
	begin
	       S <= A+B;
	         
	end process;
end Behavioral;
