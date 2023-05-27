library ieee;
use ieee.std_logic_1164.all;

entity tb_CheckBit is
end tb_CheckBit;

architecture tb of tb_CheckBit is

    component CheckBit
        port (A    : in std_logic_vector (3 downto 0);
              ones : out std_logic_vector (2 downto 0));
    end component;

    signal A    : std_logic_vector (3 downto 0);
    signal ones : std_logic_vector (2 downto 0);

begin

    dut : CheckBit
    port map (A    => A,
              ones => ones);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <= (others => '1');

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;