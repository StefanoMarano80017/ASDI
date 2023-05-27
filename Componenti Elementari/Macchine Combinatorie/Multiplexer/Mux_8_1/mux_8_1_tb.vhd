library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_8_1_tb is
end;

architecture bench of mux_8_1_tb is

  component mux_8_1
      Port ( A0 : in STD_LOGIC;
             A1 : in STD_LOGIC;
             A2 : in STD_LOGIC;
             A3 : in STD_LOGIC;
             A4 : in STD_LOGIC;
             A5 : in STD_LOGIC;
             A6 : in STD_LOGIC;
             A7 : in STD_LOGIC;
             S2 : in STD_LOGIC;
             S1 : in STD_LOGIC;
             S0 : in STD_LOGIC;
             Y : out STD_LOGIC
  );
  end component;
  signal input 	: STD_LOGIC_VECTOR (0 to 7) 	:= (others => '0');
  signal control : STD_LOGIC_VECTOR (2 downto 0) := (others => '0');
  signal output : STD_LOGIC := '0';

 

begin

  uut: mux_8_1 port map ( A0 => input(0),
                          A1 => input(1),
                          A2 => input(2),
                          A3 => input(3),
                          A4 => input(4),
                          A5 => input(5),
                          A6 => input(6),
                          A7 => input(7),
                          S2 => control(2),
                          S1 => control(1),
                          S0 => control(0),
                          Y  => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
     wait for 4 ns;
	 input 	<= "00111111";
	 control <= "101"; 
	 wait for 4 ns;
	 input 	<= "11111111";
	 control <= "111";  
	 wait for 4 ns;
	 input 	<= "11011110";
	 control <= "100";
		
		
		


    -- Put test bench stimulus code here

    wait;
  end process;


end;

