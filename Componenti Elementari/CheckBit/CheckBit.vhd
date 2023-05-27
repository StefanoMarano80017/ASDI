library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CheckBit is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           ones : out  STD_LOGIC_VECTOR (2 downto 0));
end CheckBit;

architecture Behavioral of CheckBit is

begin

process(A)
variable count : unsigned(2 downto 0) := "000";
begin
    count := "000";   --initialize count variable.
    for i in 0 to 3 loop   --check for all the bits.
        if(A(i) = '1') then --check if the bit is '1'
            count := count + 1; --if its one, increment the count.
        end if;
    end loop;
    ones <= std_logic_vector(count);    --assign the count to output.
end process;

end Behavioral;