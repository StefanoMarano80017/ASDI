library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MacchinaComb4_3 is
  Port ( 
        x: in std_logic_vector(3 downto 0);
        flag: out std_logic:='0';
        y: out std_logic_vector(2 downto 0)
  );
end MacchinaComb4_3;

architecture dataflow of MacchinaComb4_3 is
begin



process(x)

begin
	flag<='0'; 
	if(x="1111") then
	   y <= "000";
	   flag<='1';
	elsif(x="1110") then
	   y <= "001";
	   flag<='1';
	elsif(x="1100") then
	   y <= "011";
	   flag<='1';
	elsif(x="1000") then
	   y <= "111";
	   flag<='1';
	   elsif(x="0100") then
	   y <= "010";
	   flag<='1';
	elsif(x="0101") then
	   y <= "011";
	   flag<='1';
	   
	    elsif(x="1100") then
	   y <= "010";
	   flag<='1';
	elsif(x="0101") then
	   y <= "011";
	   flag<='1';
	   end if;
	         
    
      
    
     
    
    
end process;
     
     
     


end dataflow;
