library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity mantieni_uscita_tb is
end;

architecture bench of mantieni_uscita_tb is

  component mantieni_uscita
      Port ( a0 : in std_logic_vector(16 downto 0);
              a1 : in std_logic_vector(16 downto 0);
              a2 : in std_logic_vector(16 downto 0);
              a3 : in std_logic_vector(16 downto 0);
              a4 : in std_logic_vector(16 downto 0);
              click : in std_logic;
              clk : in std_logic;
              y_sec : out std_logic_vector(5 downto 0);
              y_min : out std_logic_vector(5 downto 0);
              y_ore : out std_logic_vector(4 downto 0)
          );
  end component;

  signal a0: std_logic_vector(16 downto 0);
  signal a1: std_logic_vector(16 downto 0);
  signal a2: std_logic_vector(16 downto 0);
  signal a3: std_logic_vector(16 downto 0);
  signal a4: std_logic_vector(16 downto 0);
  signal click: std_logic;
  signal clk: std_logic;
  signal y_sec: std_logic_vector(5 downto 0);
  signal y_min: std_logic_vector(5 downto 0);
  signal y_ore: std_logic_vector(4 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: mantieni_uscita port map ( a0    => a0,
                                  a1    => a1,
                                  a2    => a2,
                                  a3    => a3,
                                  a4    => a4,
                                  click => click,
                                  clk   => clk,
                                  y_sec => y_sec,
                                  y_min => y_min,
                                  y_ore => y_ore );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10 ns;
    a0 <= "00000000000000000";
    wait for 10 ns;
    a1 <= "10000000000000000";
    wait for 10 ns;
    a2 <= "11000000000000000";
    wait for 10 ns;
    a3 <= "11100000000000000";
    wait for 10 ns;
    a4 <= "11110000000000000";
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
    wait for 10 ns;
    click <= '1';
    wait for 10 ns;
    click <= '0';
   

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


