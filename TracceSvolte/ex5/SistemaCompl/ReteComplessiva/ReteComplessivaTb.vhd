library ieee;
use ieee.std_logic_1164.all;

entity tb_ReteComplessiva is
end tb_ReteComplessiva;

architecture tb of tb_ReteComplessiva is

    component ReteComplessiva
        port (ClockA   : in std_logic;
              ClockB   : in std_logic;
              ResetA   : in std_logic;
              ResetB   : in std_logic;
              StartB   : in std_logic;
              InUtente : in std_logic_vector (2 downto 0));
    end component;

    signal ClockA   : std_logic;
    signal ClockB   : std_logic;
    signal ResetA   : std_logic;
    signal ResetB   : std_logic;
    signal StartB   : std_logic;
    signal InUtente : std_logic_vector (2 downto 0);
    constant CLK_periodA: time := 27 ns;
    constant CLK_periodB: time := 30 ns;

begin

    dut : ReteComplessiva
    port map (ClockA   => ClockA,
              ClockB   => ClockB,
              ResetA   => ResetA,
              ResetB   => ResetB,
              StartB   => StartB,
              InUtente => InUtente);
              
              CLK_processA :process
   begin
		ClockA <= '0';
		wait for CLK_periodA/2;
		ClockA  <= '1';
		wait for CLK_periodA/2;
   end process;
         
              CLK_processB :process
   begin
		ClockB <= '0';
		wait for CLK_periodB/2;
		ClockB  <= '1';
		wait for CLK_periodB/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 10ns;
        StartB <= '1';
        InUtente <="010";
        wait for 10ns;
        StartB <= '0';
        
        
        wait for 1000ns;
         wait for 10ns;
        StartB <= '1';
        InUtente <="010";
        wait for 10ns;
        StartB <= '0';
        wait for 800ns;
        
         wait for 2000ns;
        StartB <= '1';
        InUtente <="010";
        wait for 10ns;
        StartB <= '0';
        
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;