library ieee;
use ieee.std_logic_1164.all;

entity CheckParityBit is
    port (
        data : in std_logic_vector(7 downto 0);
        parity_bit : out std_logic
    );
end entity;

architecture behavioral of CheckParityBit is
    signal count : integer range 0 to 8 := 0;
begin
    parity_bit <= data(0) xor data(1) xor data(2) xor data(3) xor
                  data(4) xor data(5) xor data(6) xor data(7);
end architecture;
