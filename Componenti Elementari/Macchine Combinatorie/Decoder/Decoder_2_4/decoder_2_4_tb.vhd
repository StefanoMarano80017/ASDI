library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity demux_2_4_tb is
end;

architecture bench of demux_2_4_tb is

  component demux_2_4
    port ( 
    a: in std_logic_vector( 0 to 1);
    enable: in std_logic;
    u: out std_logic_vector( 0 to 3)
    );
  end component;

  signal input: std_logic_vector( 0 to 1);
  signal controlEn: std_logic;
  signal output: std_logic_vector( 0 to 3) ;

begin

  uut: demux_2_4 port map ( a      => input,
                            enable => controlEn,
                            u      => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 4ns;
    input <="00";
    controlEn <='1'; 
    wait for 4ns;
    input <="01";
    controlEn <='1';
     wait for 4ns;
    input <="11";
    controlEn <='1';
     wait for 4ns;
    input <="00";
    controlEn <='0';
     wait for 4ns;
    input <="10";
    controlEn <='1';
     wait for 4ns;
    input <="00";
    controlEn <='0';
   
 

    -- Put test bench stimulus code here

    wait;
  end process;


end;