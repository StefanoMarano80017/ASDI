library ieee;
use ieee.std_logic_1164.all;

entity tb_ContModN is
end tb_ContModN;

architecture tb of tb_ContModN is

    component ContModN
        port (Clk  : in std_logic;
              Rst  : in std_logic;
              Enable :in std_logic;
              Cont : out std_logic_vector (2 downto 0));
    end component;

    signal Clock  : std_logic;
    signal Reset  : std_logic;
    signal EnableCont  : std_logic;
    signal Output : std_logic_vector (2 downto 0);
      constant CLK_period: time := 10 ns;
begin

    dut : ContModN
    port map (Clk  => Clock,
              Enable  => EnableCont,
              Rst  => Reset,
              Cont => Output);
   CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock <= '1';
		wait for CLK_period/2;
   end process;
    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        EnableCont<='0';
        wait for 50ns;
        EnableCont<='1';
        wait for 10 ns;
         
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '1';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;
		  Reset <= '0';
		  wait for 10 ns;
		  Reset <= '1';
		   wait for 20 ns;
		  Reset <= '0'; 

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;