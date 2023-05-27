library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoAPo is
generic (N: natural := 5);
    Port ( 
        ClockA: in std_logic;
        ResetA: in std_logic;
        ---sengali registro Tx
        EnTx:in std_logic;
        SendTx:in std_logic;
        ---sengali registro Rx
        EnAddr :in std_logic;
        EnRead:in std_logic;
        EndRead:out std_logic:= '0';
        OUT_FROM_A : out std_logic_vector(N downto 0) := "000000"
    );
end NodoAPo;

architecture structural of NodoAPo is
component MemoriaA is
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
end component;

component RegistroB is
   generic(N: natural:=5);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end  component;
signal OutFromMemTmp:std_logic_vector(N downto 0):="000000";
begin
MemA:MemoriaA 
    Port map(
		  ClkIn =>ClockA,
		  RstIn => ResetA,
		  EnRead => EnRead,
		  EndRead => EndRead,
		  cnt => EnAddr,
		  OutData =>OutFromMemTmp
		);

TxB:RegistroB 
	port map(
		ClockRx =>ClockA, 
		ResetRx=> ResetA,
		InRx =>OutFromMemTmp,
		WriteRx => EnTx,
		ReadRx =>SendTx,
		OutRx =>OUT_FROM_A
	);




end structural;
