library ieee;
use ieee.std_logic_1164.all;

entity tb_ContModN is
end tb_ContModN;

architecture tb of tb_ContModN is

    component ContModN
        port (clock     : in std_logic;
              reset     : in std_logic;
              enable    : in std_logic;
              counter   : out std_logic_vector (2 downto 0);
              stopCount : out std_logic);
    end component;

    signal clock     : std_logic;
    signal reset     : std_logic;
    signal enable    : std_logic;
    signal counter   : std_logic_vector (2 downto 0);
    signal stopCount : std_logic;
    constant CLK_period: time := 10 ns;

begin

    dut : ContModN
    port map (clock     => clock,
              reset     => reset,
              enable    => enable,
              counter   => counter,
              stopCount => stopCount);
              CLK_process :process
   begin
		clock <= '0';
		wait for CLK_period/2;
		clock  <= '1';
		wait for CLK_period/2;
   end process;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        enable <= '1';
        wait for 80ns;
        enable <= '0';
        reset<='1';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;