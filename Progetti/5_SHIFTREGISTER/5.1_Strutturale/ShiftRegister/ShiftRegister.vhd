library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ShiftRegister is 
	generic (N : integer := 4);
	port(
		x : in std_logic;  --dato in input seriale
		xDati: in std_logic_vector (0 to N-1);--dato in input parallelo
		load: in std_logic;-- abilitazione ingresso in parallelo
		clk : in std_logic;
		rst : in std_logic;
		stato : in std_logic; -- se è 0-->shifto una posizione alla volta; 
		                      --se è 1-->shifto due posizioni alla volta;                      
		shift: in std_logic;  -- se è 0-->shifto a destra;
		                      -- se è 1-->shifto a sinistra; 	
		y: out std_logic_vector (0 to N-1)
		);
end ShiftRegister;
architecture Structural of ShiftRegister is
    signal outMux4:std_logic_vector(0 to N-1);
    signal outMux2:std_logic_vector(0 to N-1);
    signal outFFd:std_logic_vector(0 to N-1);
    component FlipFlopD 
        port (
              clk: in std_logic;
              rst: in std_logic;
              d: in std_logic;
              q: out std_logic
        );
    end component;
    component mux_4_1 is 
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
    component mux_2_1 is
        Port ( 
              a0 : in STD_LOGIC;
              a1 : in STD_LOGIC;
              s : in STD_LOGIC;
              y : out STD_LOGIC
        );
    end component;

begin
        --COMP_0
            Mux4_0:mux_4_1
            Port Map(
                b0 =>x,
                b1 =>'0',
                b2 =>outFFd(1),
                b3 =>outFFd(2),
                s0 =>stato,
                s1 =>shift,
                y0 =>outMux4(0)
            );
            Mux2_0:mux_2_1
            Port Map(
                a0 =>outMux4(0),
                a1 =>xDati(0),
                s => load,
                y =>outMux2(0)
                
            );
             FFD_0:FlipFlopD
             Port Map(
                clk=>clk,
                rst =>rst,
                d =>outMux2(0),
                q =>outFFd(0)
             );
        --COMP_1
            Mux4_1:mux_4_1
            Port Map(
                b0 =>outFFd(0),
                b1 =>x,
                b2 =>outFFd(2),
                b3 =>outFFd(3),
                s0 =>stato,
                s1 =>shift,
                y0 =>outMux4(1)
            );
            Mux2_1:mux_2_1
            Port Map(
                a0 =>outMux4(1),
                a1 =>xDati(1),
                s => load,
                y =>outMux2(1)
                
            );
             FFD_1:FlipFlopD
             Port Map(
                clk=>clk,
                rst =>rst,
                d =>outMux2(1),
                q =>outFFd(1)       
             );
         --COMP_2
            Mux4_2:mux_4_1
            Port Map(
                b0 =>outFFd(1),
                b1 =>outFFd(0),
                b2 =>outFFd(3),
                b3 =>x,
                s0 =>stato,
                s1 =>shift,
                y0 =>outMux4(2)
            );
            Mux2_2:mux_2_1
            Port Map(
                a0 =>outMux4(2),
                a1 =>xDati(2),
                s => load,
                y =>outMux2(2)
                
            );
             FFD_2:FlipFlopD
             Port Map(
                clk=>clk,
                rst =>rst,
                d =>outMux2(2),
                q =>outFFd(2)       
             );
             
             --COMP_3
            Mux4_3:mux_4_1
            Port Map(
                b0 =>outFFd(2),
                b1 =>outFFd(1),
                b2 =>x,
                b3 =>'0',
                s0 =>stato,
                s1 =>shift,
                y0 =>outMux4(3)
            );
            Mux2_3:mux_2_1
            Port Map(
                a0 =>outMux4(3),
                a1 =>xDati(3),
                s => load,
                y =>outMux2(3)
                
            );
             FFD_3:FlipFlopD
             Port Map(
                clk=>clk,
                rst =>rst,
                d =>outMux2(3),
                q =>outFFd(3)       
             );
            
y<=outFFd;

end Structural;
