library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is 
	generic (N : integer := 9);
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

architecture behavioral of ShiftRegister is

	signal T : std_logic_vector (0 to N-1);
	
	begin
	ShiftReg : process(clk, rst)
	begin
	if (rst = '1') then
		T <= (others => '0');
	elsif (load = '1') then
	   T <=xDati;
	elsif (CLK'event and CLK = '1') then
		--SHIFT A Sinistra una posizione per volta
		if (shift = '1' and stato = '0') then
			T(N-1) <= x; -- se N=4 ----> T(3)=x;
			T(0 to N-2) <= T(1 to N-1); --  se N=4----> pongo  T(0) <= T(1),T(1) <= T(2),T(2) <= T(3)  
		--SHIFT A Sinistra due posizioni per volta	
		elsif (shift = '1' and stato = '1') then
		   -- T(N-1) <='0'; --pongo l'ultimo bit N-1 a  0
			T(N-2) <= x; -- se N=4 ----> T(2)=x, pertanto  il secondo bit ad x in maniera tale da avere --x0
			T(0 to N-3) <= T(2 to N-1); -- se N=4----> pongo  T(0) <= T(2),T(1) <= T(3)
			
		--SHIFT A Destra una posizione per volta
		elsif (shift = '0' and stato = '0') then
			T(1 to N-1) <= T(0 to N-2); --  se N=4----> pongo  T(1) <= T(0),T(2) <= T(1),T(3) <= T(2)  
			T(0) <= x;
		--SHIFT A Destra due posizioni per volta	
		elsif (shift = '0' and stato = '1') then
			T(2 to N-1) <= T(0 to N-3); -- se N=4----> pongo  T(2) <= T(0),T(3) <= T(1)
			T(1) <= x; 
			--T(0) <= '0'; --con queste due assegnazione pongo il secondo bit ad x in maniera tale da avere 0x---
		end if;
	end if;
	end process;	

	y <= T;

end behavioral;
         