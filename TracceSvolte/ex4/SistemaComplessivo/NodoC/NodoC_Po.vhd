


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoC_Po is
 generic (N:integer:=7);
  Port ( 
          ClkC:in STD_LOGIC;
		  RstC: in STD_LOGIC;
		  InFromB: in std_logic_vector(N downto 0);
		  InXBStr: in string(1 to 3);
		  --segnali Memoria
		  EnWriteMem: in STD_LOGIC;
		  EnAddr: in STD_LOGIC;
		  FineLett: out  STD_LOGIC;
          ---segnali Registro RX_C
          EnRx: in  STD_LOGIC;
          SendRx: in  STD_LOGIC;
           ---segnali Registro REGISTRO_STRINGA
	  FlagStringaFF: out std_logic;
          WriteRStr: in std_logic);
         

end NodoC_Po;

architecture structural of NodoC_Po is
component MemoriaC is
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
end component;

component Registro is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;
component RegistroValStringa is
   generic(N: natural:=3);
	port(
		ClockRx: in std_logic;
		WriteRx: in std_logic;
		FlagStringa: out std_logic;
		InRx: in string(1 to 3)
	);
end component;


signal OutRxtmp :std_logic_vector(7 downto 0);
begin
MemC: MemoriaC 
    Port map(
		  ClkIn=>ClkC,
		  RstIn=>RstC,
		  EnWrite =>EnWriteMem,
		  EndRead => FineLett,
		  cnt =>EnAddr,
		  InData=>OutRxtmp
		 
		);
RegistroRx:Registro 
	port map(
		ClockRx=>ClkC,
		ResetRx=>RstC,
		InRx=>InFromB,
		WriteRx=>EnRx,
		ReadRx=>SendRx,
		OutRx=>OutRxtmp
	);
RegStringa:RegistroValStringa 
	port map(
		ClockRx=>ClkC,
		WriteRx=>WriteRStr,
		FlagStringa=>FlagStringaFF,
		InRx=>InXBStr
	);
end structural;
