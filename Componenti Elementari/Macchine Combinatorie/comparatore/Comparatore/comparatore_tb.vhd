library ieee;
use ieee.std_logic_1164.all;

entity tb_comparatore is
end tb_comparatore;

architecture tb of tb_comparatore is

    component comparatore
        port (a       : in std_logic_vector (7 downto 0);
              b       : in std_logic_vector (7 downto 0);
              greater : out std_logic);
    end component;

    signal a       : std_logic_vector (7 downto 0);
    signal b       : std_logic_vector (7 downto 0);
    signal greater : std_logic;

begin

    dut : comparatore
    port map (a       => a,
              b       => b,
              greater => greater);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        a <= (others => '1');
        b <= (others => '0');
        wait for 10ns;
         a <= (others => '0');
         b <= (others => '1');
        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
