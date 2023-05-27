library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux_8_1 is
    Port ( A0 : in STD_LOGIC;
           A1 : in STD_LOGIC;
           A2 : in STD_LOGIC;
           A3 : in STD_LOGIC;
           A4 : in STD_LOGIC;
           A5 : in STD_LOGIC;
           A6 : in STD_LOGIC;
           A7 : in STD_LOGIC;
           S2 : in STD_LOGIC;
           S1 : in STD_LOGIC;
           S0 : in STD_LOGIC;
           Y : out STD_LOGIC
);
end mux_8_1;

architecture Structural of mux_8_1 is
    signal u0 : STD_LOGIC := '0';
	signal u1 : STD_LOGIC := '0';
    component mux_2_1
		port(	a0 	: in STD_LOGIC;
				a1 	: in STD_LOGIC;
				s 	: in STD_LOGIC;
				y 	: out STD_LOGIC
			);	
	end component;
	
	
    component mux_4_1 is 
	port(	b0 : in STD_LOGIC;
			b1 : in STD_LOGIC;
			b2 : in STD_LOGIC;
			b3 : in STD_LOGIC;
			s1 : in STD_LOGIC;
			s0 : in STD_LOGIC;
			y0 : out STD_LOGIC
		);	
end component;
begin

    mux4_0: mux_4_1 
			Port map(	b0 	=> A0,
						b1 	=> A1,
						b2 	=> A2,
						b3 	=> A3,
						s0 	=> S0,
						s1 	=> S1,
						y0 	=> u0
					);
					
    mux4_1: mux_4_1 
			Port map(	b0 	=> A4,
						b1 	=> A5,
						b2 	=> A6,
						b3 	=> A7,
						s0 	=> S0,
						s1 	=> S1,
						y0 	=> u1
					);
					
					
	mux2_0: mux_2_1 
			Port map(	a0 	=> u0,
						a1 	=> u1,
						s 	=> S2,
						y 	=> Y
					);
				







end Structural;
