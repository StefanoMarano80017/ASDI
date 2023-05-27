
library ieee;
use ieee.std_logic_1164.all;

entity tb_ContaBit is
end tb_ContaBit;

architecture tb of tb_ContaBit is

    component ContaBit
        port (a : in std_logic_vector (7 downto 0);
              b : in std_logic_vector (7 downto 0);
              y : out std_logic_vector (7 downto 0));
    end component;

    signal a : std_logic_vector (7 downto 0);
    signal b : std_logic_vector (7 downto 0);
    signal y : std_logic_vector (7 downto 0);

begin

    dut : ContaBit
    port map (a => a,
              b => b,
              y => y);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= (others => '1');
        b <= (others => '0');
         
         
        wait for 20ns;
        
        a <="10000000";
        b <= (others => '1');

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;