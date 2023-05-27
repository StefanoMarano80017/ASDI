library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
entity Sottrattore is
	generic(N:integer:=0);
	port(
		a,b : in std_logic:='0';
		cin : in std_logic:='0';
		s,cout : out std_logic:='0'
	);
end Sottrattore;
architecture Behavioral of Sottrattore is
signal diff1,a1,b1,r1 : std_logic_vector(0 downto 0):="0";
begin
DifferenzaBitoBit: process (a,b,cin)

    begin
    if(a='0' and b='0' and cin='0') then
        cout<='0';
        s <='0';
    elsif(a='0' and b='0' and cin='1') then
        cout<='1';
        s <='1';
    elsif(a='0' and b='1' and cin='0') then
        cout<='1';
        s <='1';
        
        
 elsif(a='0' and b='1' and cin='1') then
 
 cout<='1';
        s <='0';
        
       
 elsif(a='1' and b='0' and cin='0') then
 cout<='0';
        s <='1';
        
        
        
 elsif(a='1' and b='0' and cin='1') then
 cout<='0';
        s <='0';
        
        
        
 elsif(a='1' and b='1' and cin='0') then
 cout<='0';
        s <='0';
        
 
 
  elsif(a='1' and b='1' and cin='1') then
  cout<='1';
        s <='1';
        
  
  end if;
        
        
 
    
  
	end process;


end Behavioral;