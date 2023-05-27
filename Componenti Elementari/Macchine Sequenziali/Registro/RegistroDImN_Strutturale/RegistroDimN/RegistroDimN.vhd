library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ShiftRegister is
  generic( N:natural :=8);
  Port ( Clock: in std_logic;
         Reset: in std_logic;
         EnData: in std_logic;
         InData :in std_logic_vector(N-1 downto 0);
         OutData :out std_logic_vector(N-1 downto 0)
  );
end ShiftRegister;
architecture structural of ShiftRegister is
    component FlipFlopD is
	   port (
		  clk: in std_logic;
		  rst: in std_logic;
		  enble: in std_logic;
		  d: in std_logic;
		  q: out std_logic
	  );
end component;

begin
    ComponenteFF: for i in N-1 downto 0 
    generate D: FlipFlopD
    Port map(
        clk => Clock,
        enble => EnData,
        rst => Reset,
        d => InData(i),
        q => OutData(i)
);
end generate;
    

end structural;
