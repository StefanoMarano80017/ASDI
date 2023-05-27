library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity demux_1_4 is
    Port (
    d : in std_logic;
    s : in std_logic_vector (1 downto 0);
    u : out std_logic_vector (0 to 3)
    );
end demux_1_4;

architecture Dataflow of demux_1_4 is

	begin

		WITH s SELECT
			u <= (d & "000") WHEN  "00",
				"0" & d & "00" WHEN  "01",
				"00" & d & "0" WHEN  "10",
				"000" & d WHEN  "11",
				"----" WHEN others;   

end Dataflow;

