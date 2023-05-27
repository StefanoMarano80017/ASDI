library ieee;
use ieee.std_logic_1164.all;

entity tb_SistemaComplessivo is
end tb_SistemaComplessivo;

architecture tb of tb_SistemaComplessivo is

    component SistemaComplessivo
        port (Start  : in std_logic;
              ClockA : in std_logic;
              ClockB : in std_logic;
              ClockC : in std_logic;
              Reset  : in std_logic);
    end component;

    signal Start  : std_logic;
    signal ClockA : std_logic;
    signal ClockB : std_logic;
    signal ClockC : std_logic;
    signal Reset  : std_logic;
    constant CLK_periodA: time := 20 ns;
    constant CLK_periodB: time := 23 ns;
    constant CLK_periodC: time := 17 ns;

begin

    dut : SistemaComplessivo
    port map (Start  => Start,
              ClockA => ClockA,
              ClockB => ClockB,
              ClockC => ClockC,
              Reset  => Reset);
              
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
   
   CLK_processC :process
   begin
		ClockC <= '0';
		wait for CLK_periodC/2;
		ClockC  <= '1';
		wait for CLK_periodC/2;
   end process;


    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        Start <= '0';
        wait for 40ns;
        Start <= '1';
        wait for 40ns;
        Start <= '0';
        

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;