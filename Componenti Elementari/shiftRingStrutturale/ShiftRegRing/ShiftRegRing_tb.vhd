library ieee;
use ieee.std_logic_1164.all;

entity tb_ShiftRegRing is
end tb_ShiftRegRing;

architecture tb of tb_ShiftRegRing is

    component ShiftRegRing
        port (clk  : in std_logic;
              load : in std_logic;
              d    : in std_logic_vector (0 to 3);
              q    : inout std_logic_vector (0 to 3);
              qout : out std_logic:='0'
              
              );
    end component;

    signal clk  : std_logic;
    signal load : std_logic;
    signal d    : std_logic_vector (0 to 3);
    signal q    : std_logic_vector (0 to 3);
    signal qout :  std_logic:='0';
    constant CLK_period: time := 10 ns;

begin

    dut : ShiftRegRing
    port map (clk  => clk,
              load => load,
              d    => d,
              q    => q,
              qout=>qout);

    CLK_process :process
   begin
		clk <= '0';
		wait for CLK_period/2;
		clk  <= '1';
		wait for CLK_period/2;
   end process;
    
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       wait for 10ns;
        d <= "1000";
        load<='1';
        wait for 10ns;
        load<='0';
        wait for 10ns;
       -- load<='1';
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;