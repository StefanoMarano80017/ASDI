
library ieee;
use ieee.std_logic_1164.all;

entity tb_Addizionatore is
end tb_Addizionatore;

architecture tb of tb_Addizionatore is

    component Addizionatore
        port (A : in std_logic_vector (3 downto 0);
              B : in std_logic_vector (3 downto 0);
              S : out std_logic_vector (3 downto 0));
    end component;

    signal A : std_logic_vector (3 downto 0);
    signal B : std_logic_vector (3 downto 0);
    signal S : std_logic_vector (3 downto 0);

begin

    dut : Addizionatore
    port map (A => A,
              B => B,
              S => S);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <="1010";
        B <= "0001";

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
