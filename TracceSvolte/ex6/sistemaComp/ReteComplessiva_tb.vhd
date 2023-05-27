library ieee;
use ieee.std_logic_1164.all;

entity tb_ReteComplessiva is
end tb_ReteComplessiva;

architecture tb of tb_ReteComplessiva is

    component ReteComplessiva
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
    constant CLK_periodA: time := 17 ns;
    constant CLK_periodB: time := 20 ns;

begin

    dut : ReteComplessiva
    port map (CLKA  => CLKA,
              CLKB  => CLKB,
              RSTA  => RSTA,
              RSTB  => RSTB,
              START => START);
   CLK_processA :process
   begin
		CLKA <= '0';
		wait for CLK_periodA/2;
		CLKA  <= '1';
		wait for CLK_periodA/2;
   end process;
   
    CLK_processB :process
   begin
		CLKB <= '0';
		wait for CLK_periodB/2;
		CLKB  <= '1';
		wait for CLK_periodB/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       wait for 20ns;
       START<='1';
        wait for 20ns;
       START<='0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;