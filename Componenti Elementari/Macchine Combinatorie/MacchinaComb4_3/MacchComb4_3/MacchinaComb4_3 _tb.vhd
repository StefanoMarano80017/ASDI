library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MacchinaComb4_3_tb is
end;

architecture bench of MacchinaComb4_3_tb is

  component MacchinaComb4_3
    Port ( 
          x: in std_logic_vector(3 downto 0);
          flag: out std_logic:='0';
          y: out std_logic_vector(2 downto 0)
    );
  end component;

  signal input: std_logic_vector(3 downto 0);
  signal output: std_logic_vector(2 downto 0) ;
signal flg: std_logic:='0';
begin

  uut: MacchinaComb4_3 port map ( x => input,
                                    flag =>flg,
                                  y => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 5ns;
    input<="1111";
  
    wait for 5ns;
    input<="0001";

    -- Put test bench stimulus code here

    wait;
  end process;


end;