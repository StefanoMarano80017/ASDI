library ieee;
use ieee.std_logic_1164.all;

entity tb_CheckParityBit is
end tb_CheckParityBit;

architecture tb of tb_CheckParityBit is

    component CheckParityBit
        port (data       : in std_logic_vector (7 downto 0);
              parity_bit : out std_logic);
    end component;

    signal data       : std_logic_vector (7 downto 0);
    signal parity_bit : std_logic;

begin

    dut : CheckParityBit
    port map (data       => data,
              parity_bit => parity_bit);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        data <= "00000111";

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;