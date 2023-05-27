library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity demux_1_2 is
    generic(N:natural:=6);
    Port (
    input : in std_logic_vector (N-1 downto 0);
    s : in std_logic;
    out_1 : out std_logic_vector (N-1 downto 0);
    out_2 : out std_logic_vector (N-1 downto 0)
    );
end demux_1_2;

architecture Behavioral of demux_1_2 is

	begin

		out_1 <= input when s = '0' else
         (others => '0') when s = '1' else
         "------"; 
         
         out_2 <= input when s = '1' else
         (others => '0') when s = '0' else
         "------";

end Behavioral;

