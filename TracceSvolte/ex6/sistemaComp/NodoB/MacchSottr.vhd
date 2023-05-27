library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MacchSottr is
generic(
    N : integer := 4
    );
  Port ( 
    A :in std_logic_vector(N-1 downto 0):="0000";
    B1 :in std_logic_vector(N-3 downto 0):="00";
    S: out std_logic_vector(N-1 downto 0):="0000";
    C_in: in std_logic:='0';
    C_out: out std_logic:='0'
  );
end MacchSottr;

architecture structural of MacchSottr is

component Sottrattore is
	generic(N:integer:=4);
	port(
		a,b : in std_logic:='0';
		cin : in std_logic:='0';
		s,cout : out std_logic:='0'
	);
end component;
    signal sx : std_logic_vector(N-1 downto 0);
    signal cx : std_logic_vector(N-1 downto 0);
    signal B : std_logic_vector(N-1 downto 0);

begin
   B<="00"& B1;
   Gen: for i in 0 to N-1 generate
    gen_Sottr_0: if i=0 generate
    Sottr_0: Sottrattore
    port map(
        a => A(i),
        b => B(i),
        cout => cx(i),
        cin =>C_in,
        s=>S(i)
        
);
end generate;

gen_Sottr_N_1: if i<N-1 and i>0 generate
    Sottr_N_1: Sottrattore
    port map(
        a => A(i),
        b => B(i),
        cin => cx(i-1),
        cout => cx(i),
        s=>S(i)
        
);
end generate;

gen_Sottr_N: if i=N-1 and i>0 generate
    Sottr_N: Sottrattore
    port map(
        a => A(i),
        b => B(i),
        cin => cx(i-1),
        cout => C_out,
        s=>S(i)
        
);
end generate;

end generate;
end structural;
