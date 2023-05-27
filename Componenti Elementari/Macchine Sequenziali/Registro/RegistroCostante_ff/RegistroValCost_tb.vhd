library ieee;
use ieee.std_logic_1164.all;

entity tb_RegistroValCost is
end tb_RegistroValCost;

architecture tb of tb_RegistroValCost is

    component RegistroValCost
        port (ClockRx : in std_logic;
              ReadRx  : in std_logic;
              OutRx   : out string(1 to 3));
    end component;

    signal ClockRx : std_logic;
    signal ReadRx  : std_logic;
    signal OutRx   :  string(1 to 3);
    constant CLK_period: time := 10 ns;

begin

    dut : RegistroValCost
    port map (ClockRx => ClockRx,
              ReadRx  => ReadRx,
              OutRx   => OutRx);
              
      CLK_process :process
   begin
		ClockRx <= '0';
		wait for CLK_period/2;
		ClockRx  <= '1';
		wait for CLK_period/2;
   end process;        
              

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        ReadRx <= '0';
        wait for 10ns;
        ReadRx <= '1';
        wait for 10ns;
        ReadRx <= '0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
