library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cronometro_finale_tb is
end;

architecture bench of cronometro_finale_tb is

  component cronometro_finale  
  Port (
          Clock : in std_logic;
          Rst : in std_logic;
          Set : in std_logic;
          Click_visualizzazione : in std_logic;
          Stop_intertempo : in std_logic;
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
  signal Click_visualizzazione: std_logic;
  signal Stop_intertempo: std_logic;
  signal InOre: std_logic_vector(4 downto 0);
  signal InMinuti: std_logic_vector(5 downto 0);
  signal InSec: std_logic_vector(5 downto 0);
  signal OutOre: std_logic_vector(4 downto 0);
  signal OutMinuti: std_logic_vector(5 downto 0);
  signal OutSec: std_logic_vector(5 downto 0) ;
  constant CLK_period: time := 10 ns;

begin

  uut: cronometro_finale port map ( Clock                 => Clk,
                                 Rst                   => Reset,
                                 Set                   => Set,
                                 Click_visualizzazione => Click_visualizzazione,
                                 Stop_intertempo       => Stop_intertempo,
                                 SetOre                => InOre,
                                 SetMinuti             => InMinuti,
                                 SetSec                => InSec,
                                 TimerOre              => OutOre,
                                 TimerMinuti           => OutMinuti,
                                 TimerSec              => OutSec );
    CLK_process :process
   begin
		Clk <= '0';
		wait for CLK_period/2;
		Clk<= '1';
		wait for CLK_period/2;
   end process; 

  stimulus: process
  begin
  
    -- resetto 
        wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '0';
		  
		  -- setto un valore iniziale da cui cominciare il conteggio del tempo
		  wait for 10 ns;
          Set <='1';
		  InSec <="001111";
		  InMinuti <="001111";
		  InOre <="01000";
		  
		  -- verifico il funzionamento del set (quando è basso non deve prendere i valori)
          wait for 5 ns;
          Set <='0';
          InSec <="000000";
		  InMinuti <="000000";
		  InOre <="00000";
		  
		  --prendo una serie di intertempi (verifico anche la sovrascrittura di due di essi)
		  wait for 10 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  wait for 10000 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  wait for 10000 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  wait for 10000 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  wait for 10000 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  wait for 10000 ns;
		  Stop_intertempo <= '1';
		  wait for 10 ns;
		  Stop_intertempo <= '0';
		  
		  --cambio le modalità di visualizzazione del cronometro
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10000 ns;
		  Click_visualizzazione <= '1';
		  wait for 10 ns;
		  Click_visualizzazione <= '0';
		  wait for 10 ns;
		  

    wait;
  end process;


end;

  