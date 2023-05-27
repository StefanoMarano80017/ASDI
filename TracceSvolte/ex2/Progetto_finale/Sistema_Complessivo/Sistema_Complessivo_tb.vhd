library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Sistema_Complessivo_tb is
end;

architecture bench of Sistema_Complessivo_tb is

  component Sistema_Complessivo
      Port (
                  CLK_A : in std_logic;
                  CLK_B : in std_logic;
                  CLK_C : in std_logic;
                  RESET_A : in std_logic;
                  RESET_B : in std_logic;
                  RESET_C : in std_logic;
                  START_A : in std_logic
           );
  end component;

  signal CLK_A: std_logic;
  signal CLK_B: std_logic;
  signal CLK_C: std_logic;
  signal RESET_A: std_logic;
  signal RESET_B: std_logic;
  signal RESET_C: std_logic;
  signal START_A: std_logic ;
  constant CLK_period: time := 20 ns;

begin

  uut: Sistema_Complessivo port map ( CLK_A   => CLK_A,
                                      CLK_B   => CLK_B,
                                      CLK_C   => CLK_C,
                                      RESET_A => RESET_A,
                                      RESET_B => RESET_B,
                                      RESET_C => RESET_C,
                                      START_A => START_A );
    
  CLK_process :process
   begin
		CLK_A <= '0';
		CLK_B <= '0';
		CLK_C <= '0';
		wait for CLK_period/2;
		CLK_C <= '1';
		wait for CLK_period/4;
		CLK_B <= '1';
		wait for CLK_period/5;
		CLK_A <= '1';
		wait for CLK_period/5;
   end process;  
    
  stimulus: process
  begin
  
    -- Put initialisation code here
    RESET_C <= '1';
    RESET_B <= '1';
    RESET_A <= '1';
    
    
    wait for 20 ns;
    RESET_C <= '0';
    RESET_B <= '0';
    RESET_A <= '0';
    
    
    wait for 80 ns;
    START_A <= '1';
    
    
    wait for 20 ns;
    START_A <= '0';


    -- Put test bench stimulus code here

    wait;
  end process;


end;