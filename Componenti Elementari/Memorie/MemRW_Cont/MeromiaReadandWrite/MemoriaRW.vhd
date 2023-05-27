library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MemoriaRW is
generic(DataLen: natural :=3);

Port(
		  ClkIn : in  STD_LOGIC;
		  RstIn : in  STD_LOGIC;
		  EnRead : in  STD_LOGIC;
		  EnWrite : in  STD_LOGIC;
		  InData : in std_logic_vector(DataLen downto 0);
		  OutData : out std_logic_vector(DataLen downto 0)
			  );
end MemoriaRW;

architecture Structural of MemoriaRW is
COMPONENT ContModN is
   generic(N: natural :=2);
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0));
end COMPONENT;


component MemRw is
generic(
        AddrLen: natural :=2;
        DataLen: natural :=3;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic; 
    RST : in std_logic; 
                       
    READ : in std_logic;
    WRITE : in std_logic; 
                           
                           
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAIN : in std_logic_vector(DataLen downto 0);
    DATAOUT : out std_logic_vector(DataLen downto 0) 
    );
end component;


signal address : std_logic_vector(2 downto 0) := "000";
begin

counterN: ContModN
PORT MAP (
    clock => ClkIn,
    reset => RstIn,
	enable => EnRead,  --enable => EnWrite or EnRead,
	counter => address
	);


MemoriaRW: MemRw
PORT MAP (
    CLK => ClkIn, 
    RST => RstIn,
    READ =>  EnRead,
    WRITE =>EnWrite,
    ADDR => address,
    DATAOUT => OutData,
    DATAIN => InData
    );

end Structural;