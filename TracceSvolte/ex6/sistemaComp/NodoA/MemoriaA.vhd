library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MemoriaA is
    generic(
            DataLen: natural :=5
            );
    Port(
		  ClkIn:      in  STD_LOGIC;
		  RstIn:      in  STD_LOGIC;
		  EnRead:     in  STD_LOGIC;
		  EndRead:    out STD_LOGIC := '0';
		  cnt:        in STD_LOGIC;
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end MemoriaA;

architecture Structural of MemoriaA is

COMPONENT ContModNA is
    generic(
        N: natural :=3 --questo valore dipende da quante locazioni di memoria ci sono nella rom
    );
    Port ( 
           clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           stopCount : out STD_LOGIC;
           counter : out  STD_LOGIC_VECTOR (N downto 0)
    );
end COMPONENT;


component MemRwA is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=5;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
                       
    READ : in std_logic;
    
                                       
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
   
    DATAOUT : out std_logic_vector(DataLen downto 0) 
    );
end component;


signal address : std_logic_vector(3 downto 0) := "0000";
begin

counterN: ContModNA
PORT MAP (
    clock       => ClkIn,
    reset       => RstIn,
	enable      => cnt,  
	stopCount   => EndRead,
	counter     => address
	);


Memoria: MemRwA
PORT MAP (
    CLK     => ClkIn, 
    RST     => RstIn,
    READ    => EnRead,
    ADDR    => address,
    DATAOUT => OutData
    );

end Structural;
