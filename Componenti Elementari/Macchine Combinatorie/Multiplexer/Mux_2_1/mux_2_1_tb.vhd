library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_2_1_tb is
end;

architecture bench of mux_2_1_tb is

  component mux_2_1
      Port ( a0 : in STD_LOGIC;
             a1 : in STD_LOGIC;
             s : in STD_LOGIC;
             y : out STD_LOGIC);
  end component;

  signal input 	: STD_LOGIC_VECTOR (0 to 1) := (others => 'U'); 
	signal control 	: STD_LOGIC 				:= 'U';
	signal output 	: STD_LOGIC 				:= 'U';

begin

  uut: mux_2_1 port map ( a0 => input(0),
			a1 => input(1),
			s => control,
			y => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10 ns;
		
		input 	<= "01"; -- visto che control='U' in uscita c'è ancora 'U'
		wait for 10 ns; 

		control <= '1';   -- in uscita va a1='1' 
		
		wait for 5 ns; 
		input 	<= "00"; -- in uscita va ancora a1, che stavolta è '0' 
		
		wait for 5 ns; 
		input 	<= "10"; -- in uscita va ancora a1='0' 
		
		wait for 5 ns; 
		control <= '0';   -- in uscita va a0='1' 
		
		assert output = '0' 
		report "errore0"
		severity failure;

		
		wait;


    -- Put test bench stimulus code here

   
  end process;


end;
