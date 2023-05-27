library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity CronoContatori_tb is
end;

architecture bench of CronoContatori_tb is

  component CronoContatori  
  Port (
          Clock : in std_logic;
          Rst :in std_logic;
          Set :in std_logic;
          SetOre : in std_logic_vector(4 downto 0);
          SetMinuti : in std_logic_vector(5 downto 0);
          SetSec : in std_logic_vector(5 downto 0);
          TimerOre : inout std_logic_vector(4 downto 0);
          TimerMinuti : inout std_logic_vector(5 downto 0);
          TimerSec : inout std_logic_vector(5 downto 0)   
          );
  end component;

  signal Clk: std_logic;
  signal Reset: std_logic;
  signal Set: std_logic;
  signal InOre: std_logic_vector(4 downto 0);
  signal InMinuti: std_logic_vector(5 downto 0);
  signal InSec: std_logic_vector(5 downto 0);
  signal OutOre: std_logic_vector(4 downto 0);
  signal OutMinuti: std_logic_vector(5 downto 0);
  signal OutSec: std_logic_vector(5 downto 0) ;
  constant CLK_period: time := 10 ns;

begin

  uut: CronoContatori port map ( Clock       => Clk,
                                 Rst         => Reset,
                                 Set         => Set,
                                 SetOre      => InOre,
                                 SetMinuti   => InMinuti,
                                 SetSec      => InSec,
                                 TimerOre    => OutOre,
                                 TimerMinuti => OutMinuti,
                                 TimerSec    => OutSec );
                                                                                           
                             -- Clock process definitions
   CLK_process :process
   begin
		Clk <= '0';
		wait for CLK_period/2;
		Clk<= '1';
		wait for CLK_period/2;
   end process; 

  stimulus: process
  begin
  
  -- Put initialisation code here
     wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;
		  
		  
          
          Set <='1';
		  InSec <="001111";
		  InMinuti <="001111";
		  InOre <="01000";
          wait for 5 ns;
          Set <='0';
          InSec <="000000";
		  InMinuti <="000000";
		  InOre <="00000";
		  wait for 10000 ns;
		  Set <='1';
		  InSec <="000000";
		  InMinuti <="111011";
		  InOre <="10111";
          wait for 5 ns;
          Set <='0';
          Reset <= '1';
          wait for 1000 ns;
		  Reset <= '0';
		  wait for 1000 ns;
		  Set <='1';
		  InSec <="111011";
		  InMinuti <="111011";
		  InOre <="10111";
		  wait for 5 ns;
          Set <='0';
          Reset <= '1';
          wait for 1000 ns;
		  Reset <= '0';
          


    -- Put test bench stimulus code here

    wait;
  end process;


end;
  