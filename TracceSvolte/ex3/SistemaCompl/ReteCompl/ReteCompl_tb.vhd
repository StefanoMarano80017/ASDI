library ieee;
use ieee.std_logic_1164.all;

entity tb_ReteCompl is
end tb_ReteCompl;

architecture tb of tb_ReteCompl is

    component ReteCompl
        port (CLKA  : in std_logic;
              CLKB  : in std_logic;
              RSTA  : in std_logic;
              RSTB  : in std_logic;
              START : in std_logic);
    end component;

    signal CLKA  : std_logic;
    signal CLKB  : std_logic;
    signal RSTA  : std_logic;
    signal RSTB  : std_logic;
    signal START : std_logic;
    constant CLK_periodA: time := 20 ns;
    constant CLK_periodB: time := 17 ns;

begin

    dut : ReteCompl
    port map (CLKA  => CLKA,
              CLKB  => CLKB,
              RSTA  => RSTA,
              RSTB  => RSTB,
              START => START);

    CLK_processA :process
   begin
		ClkA <= '0';
		wait for CLK_periodA/2;
		ClkA  <= '1';
		wait for CLK_periodA/2;
   end process;
     CLK_processB :process
   begin
		ClkB <= '0';
		wait for CLK_periodB/2;
		ClkB  <= '1';
		wait for CLK_periodB/2;
   end process;
    
    stimuli : process
    begin
       
    wait for 10ns;
    START<='1';
    wait for 10ns;
    START<='0';
    
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;