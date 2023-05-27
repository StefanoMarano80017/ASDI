library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity L_MEM_R is
    generic(
            DataLen: natural := 23
            );
    Port(
		  ClkIn:      in  STD_LOGIC;
		  RstIn:      in  STD_LOGIC;
		  EnRead:     in  STD_LOGIC;
		  cnt:        in STD_LOGIC;
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end L_MEM_R;

architecture Structural of L_MEM_R is

COMPONENT ContModN is
    generic(
        N: natural :=3 --questo valore dipende da quante locazioni di memoria ci sono nella rom
    );
    Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0)
    );
end COMPONENT;

component MemR is
generic(
        AddrLen: natural := 3;
        DataLen: natural := 23;
        NumberCells: natural := 7
);

port(
    CLK : in std_logic; 
                       
    READ : in std_logic;
                                       
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAOUT : out std_logic_vector(DataLen downto 0) 
    );
end component;

signal address : std_logic_vector(3 downto 0) := "0000";

begin

counterN: ContModN
PORT MAP (
    clock       => ClkIn,
    reset       => RstIn,
	enable      => cnt,  
	counter     => address
);

Memoria: MemR
generic map(
        AddrLen => 3,
        DataLen => 23,
        NumberCells => 7
)
PORT MAP (
    CLK     => ClkIn, 
    READ    => EnRead,
    ADDR    => address,
    DATAOUT => OutData
);

end Structural;