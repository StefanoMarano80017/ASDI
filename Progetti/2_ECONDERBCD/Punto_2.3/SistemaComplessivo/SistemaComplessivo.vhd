library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SistemaComplessivo is
	Generic( 
			CLKIN_freq : integer := 100000000; 
			CLKOUT_freq : integer := 1000
				);
	port(
		clock: in std_logic;
		reset: in std_logic;
		input: in std_logic_vector(9 downto 0);
		anodes_out : out  STD_LOGIC_VECTOR (7 downto 0);
		cathodes_out : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end SistemaComplessivo;

architecture Structural of SistemaComplessivo is

	
	component PriorityEncoder is
		port (
			InBcd: in std_logic_vector( 9 downto 0);
            OutBcd: inout std_logic_vector( 3 downto 0)
		);
	end component;
	
	component display_seven_segments is
	Generic( 
				CLKIN_freq : integer := 100000000; 
				CLKOUT_freq : integer := 1000
				);
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           VALUE : in  STD_LOGIC_VECTOR (31 downto 0);
           ENABLE : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali cifre abilitare
           DOTS : in  STD_LOGIC_VECTOR (7 downto 0); -- decide quali punti visualizzare
           ANODES : out  STD_LOGIC_VECTOR (7 downto 0);
           CATHODES : out  STD_LOGIC_VECTOR (7 downto 0));
	end component;

	signal out_temp: std_logic_vector(3 downto 0);
	signal out_disp: std_logic_vector(31 downto 0);

begin

	PrEncoder: PriorityEncoder
		port map(
			InBcd => input,
			OutBcd => out_temp
		);

	out_disp <= "0000000000000000000000000000" & out_temp;
	
	Disp: display_seven_segments
	Generic map( 
				CLKIN_freq, 
				CLKOUT_freq
				)
    port map 
			( CLK => clock,
           RST => reset,
           VALUE => out_disp,
           ENABLE => "11111111", -- decide quali cifre abilitare
           DOTS => "00000000", -- decide quali punti visualizzare
           ANODES => anodes_out,
           CATHODES => cathodes_out
			  );

end Structural;
