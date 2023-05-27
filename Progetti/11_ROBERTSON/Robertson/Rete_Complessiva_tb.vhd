library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Rete_Complessiva_tb is
end;

architecture bench of Rete_Complessiva_tb is

  component Rete_Complessiva
  	generic (N: natural := 8);
  	port(
  		start, reset, clock: in std_logic;
  		A,B: in std_logic_vector(7 downto 0);
  		stop: out std_logic;
  		RIS: out std_logic_vector(15 downto 0)
  	);
  end component;

  signal start, reset, clock: std_logic;
  signal A,B: std_logic_vector(7 downto 0);
  signal stop: std_logic;
  signal RIS: std_logic_vector(15 downto 0) ;
  
  constant clock_period : time := 10 ns;

begin

  -- Insert values for generic parameters !!
  uut: Rete_Complessiva generic map ( N     => 8 )
                           port map ( start => start,
                                      reset => reset,
                                      clock => clock,
                                      A     => A,
                                      B     => B,
                                      stop  => stop,
                                      RIS   => RIS );
clock_process : process
  begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
  end process;

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    Start <= '1';
    A <= "11010110";
    B <= "11010110";
    wait for 10 ns;
    start <= '0';
    
    wait until stop = '1';
    wait until stop = '0';
    wait for 10 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    start <= '1';
    A <= "01010000";
    B <= "01010000";
    wait for 10 ns;
    start <= '0';
    
    wait until stop = '1';
    wait until stop = '0';
    wait for 10 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    start <= '1';
    A <= "01010000";
    B <= "11010110";
    wait for 10 ns;
    start <= '0';
    
    wait until stop = '1';
    wait until stop = '0';
    wait for 10 ns;
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    start <= '1';
    A <= "11010110";
    B <= "01010000";
    wait for 10 ns;
    start <= '0';


    -- Put test bench stimulus code here

    wait;
  end process;


end;
  