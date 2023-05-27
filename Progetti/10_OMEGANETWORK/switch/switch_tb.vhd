-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity switch_tb is
end;

architecture bench of switch_tb is
  component switch
      generic (
          N: natural:=2
      );
      Port ( 
          A0, A1: in std_logic_vector(N-1 downto 0);
          B0, B1: out std_logic_vector(N-1 downto 0);
          SRC: in std_logic;
          DST: in std_logic
      );
  end component;

  signal A0, A1: std_logic_vector(1 downto 0);
  signal B0, B1: std_logic_vector(1 downto 0);
  signal SRC: std_logic;
  signal DST: std_logic ;

begin

  -- Insert values for generic parameters !!
  uut: switch generic map ( N   => 2)
                 port map ( A0  => A0,
                            A1  => A1,
                            B0  => B0,
                            B1  => B1,
                            SRC => SRC,
                            DST => DST );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 5ns;
            A0 <= "11";
            A1 <= "01";
            SRC <= '1';
            DST <= '0';
    wait for 5ns;
            A0 <= "11";
            A1 <= "01";
            SRC <= '0';
            DST <= '1';
    wait for 5ns;
            A0 <= "11";
            A1 <= "01";
            SRC <= '0';
            DST <= '0';
     wait for 5ns;
            A0 <= "11";
            A1 <= "01";
            SRC <= '0';
            DST <= '1';
    -- Put test bench stimulus code here

    wait;
  end process;


end;
