library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_4_1_tb is

end mux_4_1_tb;

architecture behavioral of mux_4_1_tb is

	component mux_4_1
	
		port (	b0 : in STD_LOGIC;
				b1 : in STD_LOGIC;
				b2 : in STD_LOGIC;
				b3 : in STD_LOGIC;
				s0 : in STD_LOGIC;
				s1 : in STD_LOGIC;
				y0 : out STD_LOGIC
	    );
		 
	end component; 

	signal input 	: STD_LOGIC_VECTOR (0 to 3) 	:= (others => '0');
	signal control 	: STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal output 	: STD_LOGIC 					:= '0';

	begin

		uut: mux_4_1 
			Port map(	b0 => input(0),
						b1 => input(1),
						b2 => input(2),
						b3 => input(3),
						s0 => control(0),
						s1 => control(1),
						y0 => output
					);

		stim_proc: process
		begin
		
		wait for 4 ns;
		
		--input = b0 b1 b2 b3
		--control = s1 s0
		
		input 	<= "0011";
		control <= "10"; 
		wait for 10 ns; -- b2 = 1  in uscita
		
		assert output = '1'
		report "errore0"
		severity failure;
		
		
		input 	<= "0111";
		control <= "00";
		wait for 10 ns; -- b0 = 0 in uscita
		
		assert output = '0'
		report "errore1"
		severity failure;
		
		
		input 	<= "0110";
		control <= "10";
		wait for 10 ns; -- b2 = 1 in uscita
		
		assert output = '1'
		report "errore2"
		severity failure;
		
		
		input 	<= "011H";
		control <= "11"; 
		wait for 10 ns; -- b3 = high in uscita
		
		assert output = 'H'
		report "errore3"
		severity failure;
		
		
		input 	<= "0L1H";
		control <= "01"; 
		wait for 10 ns; -- b1 = low in uscita
		
		assert output = 'L'
		report "errore4"
		severity failure;
		
		
		input 	<= "0W1H";
		control <= "01"; 
		wait for 20 ns; -- b1 = weak in uscita
		
		assert output = 'W'
		report "errore5"
		severity failure;
		
		wait;
		end process;
end; 
