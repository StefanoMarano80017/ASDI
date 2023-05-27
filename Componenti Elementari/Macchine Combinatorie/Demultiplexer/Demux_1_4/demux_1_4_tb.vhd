library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity demux_1_4_tb is
end;

architecture bench of demux_1_4_tb is

  component demux_1_4
      Port (
      d : in std_logic;
      s : in std_logic_vector (1 downto 0);
      u : out std_logic_vector (0 to 3)
      );
  end component;

  signal input: std_logic;
  signal control: std_logic_vector (1 downto 0);
  signal output: std_logic_vector (0 to 3) ;

begin

  uut: demux_1_4 port map ( d => input,
                            s => control,
                            u => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
        wait for 4ns;
        input <='1';
        control <="00";
         wait for 4ns;
        input <='0';
        control <="00";
         wait for 4ns;
        input <='1';
        control <="01";
         wait for 4ns;
        input <='1';
        control <="10";
         wait for 4ns;
        input <='0';
        control <="00";
        
        
        


    -- Put test bench stimulus code here

    wait;
  end process;


end;