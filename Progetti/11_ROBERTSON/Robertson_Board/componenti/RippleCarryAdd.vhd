library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity RippleCarryAdd is
generic(
    N : integer := 4
    );
  Port ( 
    A :in std_logic_vector(N-1 downto 0);
    B :in std_logic_vector(N-1 downto 0);
    S: out std_logic_vector(N-1 downto 0);
    C_in: in std_logic;
    C_out: out std_logic
  );
end RippleCarryAdd;

architecture Structural of RippleCarryAdd is
    component FullAdder is
        Port ( 
            a,b,c_in :in std_logic;
            s,c_out :out std_logic
        );
    end component;
    signal sx : std_logic_vector(N-1 downto 0);
    signal cx : std_logic_vector(N-1 downto 0);

begin
Gen: for i in 0 to N-1 generate
    gen_FA0: if i=0 generate
    FA_0: FullAdder
    port map(
        a => A(i),
        b => B(i),
        c_out => cx(i),
        c_in =>C_in,
        s=>S(i)
        
);
end generate;

gen_FA_N_1: if i<N-1 and i>0 generate
    FA_N_1: FullAdder
    port map(
        a => A(i),
        b => B(i),
        c_in => cx(i-1),
        c_out => cx(i),
        s=>S(i)
        
);
end generate;

gen_FA_N: if i=N-1 and i>0 generate
    FA_N: FullAdder
    port map(
        a => A(i),
        b => B(i),
        c_in => cx(i-1),
        c_out => C_out,
        s=>S(i)
        
);
end generate;


end generate;
end Structural;
