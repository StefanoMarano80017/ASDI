library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity M16_D4 is
  Port ( 
        Pin: in std_logic_vector( 0 to 15);
        EnableM16: in std_logic_vector( 3 downto 0);
        EnableD4: in std_logic_vector( 1 downto 0);
        Output : out std_logic_vector( 3 downto 0)
  );
end M16_D4;

architecture Structural of M16_D4 is
       signal outMux : std_logic;
        component mux_16_1 is
                  port( 
			           I : in STD_LOGIC_VECTOR (0 to 15);
                       c : in STD_LOGIC_VECTOR (3 downto 0);
                       y : out STD_LOGIC
		          );
        end component;

        component demux_1_4 is
                  Port (
                       d : in std_logic;
                       s : in std_logic_vector (1 downto 0);
                       u : out std_logic_vector (0 to 3)
                  );
        end component;
begin
mux_16_0: mux_16_1 
			Port map(
				  I => Pin,
				  c =>EnableM16,
				  y =>outMux
			);
demux_4_0: demux_1_4 
			Port map(
				  d => outMux,
				  s =>EnableD4,
				  u=>Output
			);
     


end Structural;

