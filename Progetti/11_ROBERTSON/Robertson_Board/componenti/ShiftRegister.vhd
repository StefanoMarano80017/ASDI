library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is
	generic (N : natural := 8);
	port(
	   InOperando : in std_logic_vector (0 to N-1);
	   InFFd: in std_logic;
		Clock, Reset, Load, AddLoad, EnShift, EnFinalShift: in std_logic;
		SommaParziale : in std_logic_vector (0 to N-1);
		
		Somma_Out: out std_logic_vector (0 to N-1);
		q0 : out std_logic;
		Q : out std_logic_vector (0 to 2*N-1)
		);
end ShiftRegister;

architecture Behavioral of shiftregister is

	signal T : std_logic_vector (0 to 2*N-1);
	
	begin
	reg1 : process(Clock, Reset)
	begin
	if (Reset = '1') then
		T <= (others => '0');
	elsif (Clock' event and Clock='1') then
		if(Load = '1') then
			T <= (SommaParziale & InOperando);  --T è dato dall'and tra SommaParziale ed Operando che sto valutando
		elsif(AddLoad = '1') then    
			T(0 to N-1) <= SommaParziale;   --- carichiamo negli 8 bit più significativi di T il valore del segnale SommaParziale
		elsif(EnShift='1') then  --shifto a destra elemento per elemento
			T(1 to 2*N-1) <= T(0 to 2*N-2);
			T(0) <= InFFd;   --pongo in (0) l'uscita del ffD   
		elsif(EnFinalShift = '1') then
			T(1 to 2*N-1) <= T(0 to 2*N-2);  --shift finale a destra
		end if;
	end if;
	end process;	
	q0 <= T(2*N-1);  --assegniamo alsegnale diuscita q0 il valore del bit meno significativo di T
	Somma_Out <= T(0 to N-1); -- al segnale di uscita Somma_A gli 8 bit più significativi del segnale T
	Q <= T;  --  a Q  viene assegnato tutto ilsegnale T.(somma+riporti)

end Behavioral;