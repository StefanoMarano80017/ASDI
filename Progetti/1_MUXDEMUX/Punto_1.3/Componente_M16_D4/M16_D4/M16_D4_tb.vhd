library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity M16_D4_tb is
end;

architecture bench of M16_D4_tb is

  component M16_D4
    Port ( 
          Pin: in std_logic_vector( 0 to 15);
          EnableM16: in std_logic_vector( 3 downto 0);
          EnableD4: in std_logic_vector( 1 downto 0);
          Output : out std_logic_vector( 3 downto 0)
    );
  end component;

  signal Input: std_logic_vector( 0 to 15);
  signal ControlM16: std_logic_vector( 3 downto 0);
  signal ControlD4: std_logic_vector( 1 downto 0);
  signal Outputs: std_logic_vector( 3 downto 0) ;

begin

  uut: M16_D4 port map ( Pin       => Input,
                         EnableM16 => ControlM16,
                         EnableD4  => ControlD4,
                         Output    => Outputs );

  stimulus: process
  begin
  
    -- Put initialisation code here
       wait for 10 ns;
	   Input <= "0000000000000001";
	   ControlM16 <= "1111";
	   ControlD4 <= "11";
	   wait for 10 ns;
	   Input <= "0000000000000010";
	   ControlM16 <= "1011";
	   ControlD4 <= "11";
        wait for 10 ns;
	   Input <= "0000000000000000";
	   ControlM16 <= "0000";
	   ControlD4 <= "11";
	   wait for 10 ns;
	   Input <= "1111111111111111";
	   ControlM16 <= "1111";
	   ControlD4 <= "11";
	   wait for 10 ns;
	ControlD4 <= "11";
	wait for 10 ns;
	assert Outputs <= "1000"
	report "errore2"
	severity failure;

    -- Put test bench stimulus code here

    wait;
  end process;


end;

