library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity Memoria is
    generic(
            DataLen: natural :=3
            );
    Port(
		  ClkIn:      in  STD_LOGIC:='0';
		  RstIn:      in  STD_LOGIC:='0';
		  EnRead:     in  STD_LOGIC:='0';
		  EnWrite:    in  STD_LOGIC:='0';
		  EndRead:    out STD_LOGIC := '0';
		  cnt:        in STD_LOGIC:='0';
		  InData:     in std_logic_vector(DataLen downto 0);
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end Memoria;

architecture Structural of Memoria is

COMPONENT ContModN is
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


component MemRwB is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=3;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic:='0'; 
    RST : in std_logic:='0'; 
                       
    READ : in std_logic:='0';
    WRITE : in std_logic:='0'; 
                                       
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAIN : in std_logic_vector(DataLen downto 0);
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
	stopCount   => EndRead,
	counter     => address
	);


Memoria: MemRwB
PORT MAP (
    CLK     => ClkIn, 
    RST     => RstIn,
    READ    => EnRead,
    WRITE   => EnWrite,
    ADDR    => address,
    DATAOUT => OutData,
    DATAIN  => InData
    );

end Structural;
