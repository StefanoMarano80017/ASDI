library ieee;
use ieee.std_logic_1164.all;

entity tb_CarrySave is
end tb_CarrySave;

architecture tb of tb_CarrySave is

    component CarrySave
        port (X : in std_logic_vector (3 downto 0);
              Y : in std_logic_vector (3 downto 0);
              Z : in std_logic_vector (3 downto 0);
              s : out std_logic_vector (5 downto 0));
    end component;

    signal X : std_logic_vector (3 downto 0);
    signal Y : std_logic_vector (3 downto 0);
    signal Z : std_logic_vector (3 downto 0);
    signal s : std_logic_vector (5 downto 0);

begin

    dut : CarrySave
    port map (X => X,
              Y => Y,
              Z => Z,
              s => s);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       wait for 10ns;
       X<="1010";
       Y<="1001";
       Z<="0101";

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;