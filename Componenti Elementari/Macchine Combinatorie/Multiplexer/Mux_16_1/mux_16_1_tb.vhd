library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mux_16_1_tb is
end;

architecture bench of mux_16_1_tb is

  component mux_16_1
         port(
             I : in STD_LOGIC_VECTOR (0 to 15);
             c : in STD_LOGIC_VECTOR (3 downto 0);
             y : out STD_LOGIC
         );
  end component;

  signal inputs: STD_LOGIC_VECTOR (0 to 15);
  signal controls: STD_LOGIC_VECTOR (3 downto 0);
  signal output: STD_LOGIC;

begin

  uut: mux_16_1 port map ( I => inputs,
                           c => controls,
                           y => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    
       wait for 10 ns;	
		inputs <= "0000000001000000";
		controls <= "1001";
		wait for 10 ns;
		assert output <= '1'
		report "error0"
		severity failure;
		
		controls <= "1101";
		wait for 10 ns;
		assert output <= '0'
		report "error1"
		severity failure;

		inputs <= "0111111111111111";
		controls <= "0000";
		wait for 10 ns;
		assert output <= '0'
		report "error2"
		severity failure;
		
		inputs <= "1000000000000000";
		controls <= "0000";
		wait for 10 ns;
		assert output <= '1'
		report "error3"
		severity failure;
		
		inputs <= "1111111111111110";
		controls <= "1111";
		wait for 10 ns;
		assert output <= '0'
		report "error4"
		severity failure;
		
		inputs <= "0000000000000001";
		controls <= "1111";
		wait for 10 ns;
		assert output <= '1'
		report "error5"
		severity failure;
		
		inputs <= "1010101010101010";
		controls <= "0111";
		wait for 10 ns;
		assert output <= '0'
		report "error6"
		severity failure;
		
		controls <= "0110";
		wait for 10 ns;
		assert output <= '1'
		report "error7"
		severity failure;
		
		controls <= "0101";
		wait for 10 ns;
		assert output <= '0'
		report "error8"
		severity failure;

    

    -- Put test bench stimulus code here
    

    wait;
  end process;


end;