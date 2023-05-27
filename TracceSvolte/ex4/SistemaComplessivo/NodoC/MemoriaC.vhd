library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MemoriaC is
    generic(
            DataLen: natural :=7
            );
    Port(
		  ClkIn:      in  STD_LOGIC:='0';
		  RstIn:      in  STD_LOGIC:='0';
		  EnWrite:    in  STD_LOGIC:='0';
		  EndRead:    out STD_LOGIC := '0';
		  cnt:        in STD_LOGIC:='0';
		  InData:     in std_logic_vector(DataLen downto 0)
		  
		);
end MemoriaC;

architecture Structural of MemoriaC is

COMPONENT ContModNC is
    generic(
        N: natural :=3 --questo valore dipende da quante locazioni di memoria ci sono nella rom
    );
    Port ( 
           clock : in  STD_LOGIC:='0';
           reset : in  STD_LOGIC:='0';
		   enable : in STD_LOGIC:='0'; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           stopCount : out STD_LOGIC:='0';
           counter : out  STD_LOGIC_VECTOR (N downto 0)
    );
end COMPONENT;


component MemRC is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=7;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic:='0'; 
    RST : in std_logic:='0'; 
                       
    WRITE : in std_logic:='0'; 
                                       
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAIN : in std_logic_vector(DataLen downto 0)
   
    );
end component;


signal address : std_logic_vector(3 downto 0) := "0000";
begin

counterN: ContModNC
PORT MAP (
    clock       => ClkIn,
    reset       => RstIn,
	enable      => cnt,  
	stopCount   => EndRead,
	counter     => address
	);


Memoria: MemRC
PORT MAP (
    CLK     => ClkIn, 
    RST     => RstIn,
    WRITE   => EnWrite,
    ADDR    => address,
    DATAIN  => InData
    );

end Structural;
