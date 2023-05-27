-- Testbench created online at:
--   https://www.doulos.com/knowhow/perl/vhdl-testbench-creation-using-perl/
-- Copyright Doulos Ltd

library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity UnitOp_tb is
end;

architecture bench of UnitOp_tb is

  component UnitOp
      generic(
           N: natural:= 2;
           M: natural:= 2
      );
      Port ( 
          a0, a1, a2, a3 : in STD_LOGIC_VECTOR (N-1 downto 0);
          src: in std_logic_vector(M-1 downto 0);
          dst: in std_logic_vector(M-1 downto 0);
          b0, b1, b2, b3 : out std_logic_vector(N-1 downto 0)
      );
  end component;

  signal a0, a1, a2, a3: STD_LOGIC_VECTOR (1 downto 0);
  signal src: std_logic_vector(1 downto 0);
  signal dst: std_logic_vector(1 downto 0);
  signal b0, b1, b2, b3: std_logic_vector(1 downto 0) ;

begin

  -- Insert values for generic parameters !!
  uut: UnitOp generic map ( N   =>  2,
                            M   =>  2)
                 port map ( a0  => a0,
                            a1  => a1,
                            a2  => a2,
                            a3  => a3,
                            src => src,
                            dst => dst,
                            b0  => b0,
                            b1  => b1,
                            b2  => b2,
                            b3  => b3 );

  stimulus: process
  begin
  
    -- Put initialisation code here
        wait for 10ns;
        a0 <= "00";
        a1 <= "01";
        a2 <= "10";
        a3 <= "11";
        
        wait for 20ns;
        src <= "00";
        dst <= "01";
        
        wait for 10ns;
        src <= "01";
        dst <= "10";
        
        wait for 10ns;
        src <= "11";
        dst <= "10";
        
        wait for 10ns;
        src <= "10";
        dst <= "00";
        
        wait for 10ns;
        src <="10";
        dst <="11";
        
        wait for 10ns;
        dst <="10";
        
        wait for 10ns;
        src <= "01";
    -- Put test bench stimulus code here

    wait;
  end process;


end;

