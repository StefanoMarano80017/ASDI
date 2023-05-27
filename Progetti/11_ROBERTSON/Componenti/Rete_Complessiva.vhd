library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Rete_Complessiva is
	generic (N: natural := 8);
	port(
		start, reset, clock: in std_logic;
		A,B: in std_logic_vector(7 downto 0);
		stop: out std_logic;
		RIS: out std_logic_vector(15 downto 0)
	);
end Rete_Complessiva;

architecture Behavioral of Rete_Complessiva is


	component Registro is
	generic (N : natural := 8);
		port(
			InReg: in std_logic_vector(N-1 downto 0);
		ClockR, ResetR, EnableR: in std_logic;
		OutR: out std_logic_vector(N-1 downto 0)
		);	
	end component;
	
	component FlipFlopD is
		port (
			clk, rst, enble, d: in std_logic;
		q: out std_logic
		);
	end component;
	
	component Mux_2_1 is
		generic (N : natural := 8);
		port(
			a0, a1 : in std_logic_vector(N-1 downto 0);
           s : in STD_LOGIC;
           y : out std_logic_vector(N-1 downto 0)
			);
	end component;
	
	component SubAdd is
		generic (
			N: natural :=8
			);
		port(
			X,Y:in std_logic_vector(N-1 downto 0);
        cin:in std_logic;
        Z:out std_logic_vector(N-1 downto 0);
        cout:out std_logic
		);

	end component;
	
	component ShiftRegister is
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
	end component;
	
	component ContModN is
	   generic (N: natural := 4);
		port(
			clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo Ã¨ l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N-1 downto 0)
			);
	end component;
	
	component Control_Unit is
		port(
			clock: in std_logic;
			reset: in std_logic;
			start: in std_logic;
			q0: in std_logic;
			end_cont: in std_logic_vector(3 downto 0);
			count_enable: out std_logic;
			subt: out std_logic;
			en_mux: out std_logic;
			enable: out std_logic;
			en_ff : out std_logic;
			shift_en: out std_logic;
			fshift_en : out std_logic;
			load: out std_logic;
			load_add: out std_logic;
			stop: out std_logic
		);
	end component;
	
	signal e1,k0,k1,k2,k3 : std_logic_vector(7 downto 0);
	signal t3: std_logic_vector(3 downto 0);
	signal t1,t2,t4,t5,t6,t7,t8,t9,t10 : std_logic;
	signal s1 : std_logic_vector(15 downto 0);
	signal L, f_s, e_f: std_logic;
	signal input_ff,f1: std_logic;

begin

	R: Registro
		port map(
		      InReg => B,
			ClockR => clock,
			ResetR => reset,
			EnableR => t8,
			OutR => k1
		);	
	
	MUX: mux_2_1
		generic map (N)
		port map(
			a0 => "00000000",
			a1 => k1,
			s => t7,
			y => k2
		);
		
	input_ff <= (k1(7) and t2) or f1;
	
	FF: FlipFlopD
		port map (
			clk => clock,
			rst => reset,
			d => input_ff,
			enble => e_f,
			q => f1
		);
	
	RP: SubAdd
		generic map (N)
		port map(
			X => k3,
			Y => k2,
			cin => t10,
			Z => e1,
			cout => t1
		);
	
	SR: ShiftRegister
		generic map (N)
		port map(
		      InOperando => A,
		      InFFd => f1,
			Clock => clock,
			Reset => reset,
			Load => t5,
			AddLoad => L,
			EnShift => t9,
			EnFinalShift => f_s,
			SommaParziale => e1,
			Somma_Out => k3,
			q0 => t2,
			Q => s1
			);
	
	C: ContModN
		port map(
			clock => clock,
			reset => reset,
			enable => t6,
			counter => t3
			);
			
	UC: Control_Unit
		port map(
			clock => clock,
			reset => reset,
			start => start,
			q0 => t2,
			end_cont => t3,
			subt => t10,
			count_enable => t6,
			en_mux => t7,
			enable => t8,
			en_ff => e_f,
			shift_en => t9,
			fshift_en => f_s,
			load => t5,
			load_add => L,
			stop => t4
		);
		

		
		stop <= t4;
		RIS <= s1;

end Behavioral;

