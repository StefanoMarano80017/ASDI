library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity SubAdd is
  generic(
    N : integer := 4
    );
  Port ( 
        X,Y:in std_logic_vector(N-1 downto 0);
        cin:in std_logic;
        Z:out std_logic_vector(N-1 downto 0);
        cout:out std_logic
  );
end SubAdd;

architecture Structural of SubAdd is
component RippleCarryAdd is
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
end component;
signal complemento_y :std_logic_vector(N-1 downto 0);

begin
ComplementoY: for i in 0 to N-1 generate
    complemento_y(i)<=Y(i) xor cin;
end generate;
RCA: RippleCarryAdd port map(
             A => X,
             B => complemento_y,
            C_in => cin,
            C_out => cout,
            S=>Z

);

end Structural;
