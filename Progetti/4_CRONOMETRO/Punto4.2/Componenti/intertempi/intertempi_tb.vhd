library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity intertempi_tb is
end;

architecture bench of intertempi_tb is

  component intertempi
      Port (  secondi : in std_logic_vector(5 downto 0);
              minuti : in std_logic_vector(5 downto 0);
              ore : in std_logic_vector(4 downto 0);
              clk : in std_logic;
              reset : in std_logic;
              stop : in std_logic;
              y1 : out std_logic_vector(16 downto 0);
              y2 : out std_logic_vector(16 downto 0);
              y3 : out std_logic_vector(16 downto 0);
              y4 : out std_logic_vector(16 downto 0)
            );
  end component;

  signal secondi: std_logic_vector(5 downto 0);
  signal minuti: std_logic_vector(5 downto 0);
  signal ore: std_logic_vector(4 downto 0);
  signal clk: std_logic;
  signal reset: std_logic;
  signal stop: std_logic;
  signal y1: std_logic_vector(16 downto 0);
  signal y2: std_logic_vector(16 downto 0);
  signal y3: std_logic_vector(16 downto 0);
  signal y4: std_logic_vector(16 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: intertempi port map ( secondi => secondi,
                             minuti  => minuti,
                             ore     => ore,
                             clk     => clk,
                             reset   => reset,
                             stop    => stop,
                             y1      => y1,
                             y2      => y2,
                             y3      => y3,
                             y4      => y4 );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10 ns;
    reset <= '1';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    ore <= "00010";
    wait for 10 ns;
    minuti <= "000100";
    wait for 10 ns;
    secondi <= "001000";
    wait for 10 ns;
    stop <= '1';
    wait for 10 ns;
    ore <= "00011";
    wait for 10 ns;
    minuti <= "000110";
    wait for 10 ns;
    secondi <= "001100";
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    ore <= "00111";
    wait for 10 ns;
    minuti <= "000111";
    wait for 10 ns;
    secondi <= "001110";
    wait for 10 ns;
    stop <= '1';
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    ore <= "00101";
    wait for 10 ns;
    minuti <= "000011";
    wait for 10 ns;
    secondi <= "001010";
    wait for 10 ns;
    stop <= '1';
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    ore <= "00101";
    wait for 10 ns;
    minuti <= "000001";
    wait for 10 ns;
    secondi <= "001010";
    wait for 10 ns;
    stop <= '1';
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    ore <= "00111";
    wait for 10 ns;
    minuti <= "010001";
    wait for 10 ns;
    secondi <= "101010";
    wait for 10 ns;
    stop <= '1';
    wait for 10 ns;
    stop <= '0';
    wait for 10 ns;
    reset <= '0';
    wait for 10 ns;
    reset <= '1';
    
    
    
    

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;