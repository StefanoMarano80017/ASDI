-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity OmegaNetwork_tb is
end;

architecture bench of OmegaNetwork_tb is

  component OmegaNetwork
      generic(
          N: natural:= 6;
          payload: natural := 2;
          M: natural:= 2
      );
      Port ( 
          e0, e1, e2, e3: in std_logic;
          i0, i1, i2, i3: in std_logic_vector(N-1 downto 0);
          u0, u1, u2, u3: out std_logic_vector(payload-1 downto 0)
      );
  end component;

  signal e0, e1, e2, e3: std_logic;
  signal i0, i1, i2, i3: std_logic_vector(5 downto 0);
  signal u0, u1, u2, u3: std_logic_vector(1 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: OmegaNetwork generic map ( N       => 6,
                                  payload => 2,
                                  M       =>  2)
                       port map ( e0      => e0,
                                  e1      => e1,
                                  e2      => e2,
                                  e3      => e3,
                                  i0      => i0,
                                  i1      => i1,
                                  i2      => i2,
                                  i3      => i3,
                                  u0      => u0,
                                  u1      => u1,
                                  u2      => u2,
                                  u3      => u3 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10ns;
    e0 <= '1';
    e1 <= '1';
    e2 <= '1';
    e3 <= '1';
    i0 <="001011"; --11 a 2
    i1 <="011111"; --11 a 3
    i2 <="100010"; --10 a 0
    i3 <="110100"; --00 a 1
    
    wait for 30ns;
    e0 <= '0';
    
    wait for 30ns;
    e1 <= '0';
    -- Put test bench stimulus code here

    wait;
  end process;


end;