library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ContaBit is
    generic(N:integer:=3);
    Port ( A,B : in  STD_LOGIC_VECTOR (N downto 0);
           ones : out  STD_LOGIC_VECTOR (N downto 0));
end ContaBit;

architecture Behavioral of ContaBit is

begin

process(A,B)
variable count : unsigned(N downto 0) := (others => '0');
begin
    count := (others => '0');   --initialize count variable.
    for i in 0 to N loop   --check for all the bits.
        if(A(i) = B(i)) then --check if the bit is '1'
            count := count + 1; --if its one, increment the count.
        end if;
    end loop;
    ones <= std_logic_vector(count);    --assign the count to output.
end process;

end Behavioral;