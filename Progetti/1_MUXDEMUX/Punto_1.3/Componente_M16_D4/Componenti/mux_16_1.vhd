library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux_16_1 is
       port(
           I : in STD_LOGIC_VECTOR (0 to 15);
           c : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC
           
       );
end mux_16_1;

architecture Structural of mux_16_1 is
        signal u : STD_LOGIC_VECTOR (0 to 3) := (others => '0');
        component mux_4_1
                port(	
                        b0 : in STD_LOGIC;
			            b1 : in STD_LOGIC;
			            b2 : in STD_LOGIC;
			            b3 : in STD_LOGIC;
			            s0 : in STD_LOGIC;
			            s1 : in STD_LOGIC;
			            y0 : out STD_LOGIC
		        );
		end component;
	
        begin
        mux0: mux_4_1 
			Port map(	b0 	=> I(0),
						b1 	=> I(1),
						b2 	=> I(2),
						b3 	=> I(3),
						s0 	=> c(0),
						s1 	=> c(1),
						y0 	=> u(0)
					);
		mux1: mux_4_1 
			Port map(	b0 	=> I(4),
						b1 	=> I(5),
						b2 	=> I(6),
						b3 	=> I(7),
						s0 	=> c(0),
						s1 	=> c(1),
						y0 	=> u(1)
					);
		mux2: mux_4_1 
			Port map(	b0 	=> I(8),
						b1 	=> I(9),
						b2 	=> I(10),
						b3 	=> I(11),
						s0 	=> c(0),
						s1 	=> c(1),
						y0 	=> u(2)
					);
		mux3: mux_4_1 
			Port map(	b0 	=> I(12),
						b1 	=> I(13),
						b2 	=> I(14),
						b3 	=> I(15),
						s0 	=> c(0),
						s1 	=> c(1),
						y0 	=> u(3)
					);
		mux4: mux_4_1 
			Port map(	b0 	=> u(0),
						b1 	=> u(1),
						b2 	=> u(2),
						b3 	=> u(3),
						s0 	=> c(2),
						s1 	=> c(3),
						y0 	=> y
					);
					


end Structural;