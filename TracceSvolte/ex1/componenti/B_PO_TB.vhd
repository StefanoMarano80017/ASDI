library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity B_PO_tb is
end;

architecture bench of B_PO_tb is

  component B_PO
  Port ( 
      Clock:   in std_logic;
      Reset:   in std_logic;
      Data_in: in std_logic_vector(4 downto 0);
      cnt:     in std_logic;
      wrt:     in std_logic
  );
  end component;

  signal Clock: std_logic;
  signal Reset: std_logic;
  signal Data_in: std_logic_vector(4 downto 0);
  signal cnt: std_logic;
  signal wrt: std_logic;
  
  constant clock_period: time := 10ns;

begin

  uut: B_PO port map ( Clock   => Clock,
                       Reset   => Reset,
                       Data_in => Data_in,
                       cnt     => cnt,
                       wrt     => wrt );

  stimulus: process
  begin
  
    -- Put initialisation code here
    cnt <= '0';
    wrt <= '0';
    
    wait for 10ns;
    Data_in <= "10100";
    
    wait for 20ns;
    wrt <= '1';
    
    wait for 20ns;
    wrt <= '0';
    cnt <= '1';
    
    wait for 20ns;
    cnt <= '0';
    Data_in <= "11010";
    
    wait for 20ns;
    wrt <= '1';
    
    wait for 20ns;
    wrt <= '0';
    cnt <= '1';
    -- Put test bench stimulus code here

    wait;
  end process;
  
  clocking: process
  begin
    while True loop
      Clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;


end;
