library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoA_Po is
 generic (N:integer:=7);
  Port ( 
          ClkA:in STD_LOGIC;
		  RstA: in STD_LOGIC;
		  OutFromA: out std_logic_vector(N downto 0);
		  OutFromX: out std_logic_vector(N downto 0);
		  --segnali Memoria
		  EnRead: in STD_LOGIC;
		  EnAddr: in STD_LOGIC;
		  FineLett: out  STD_LOGIC;
          --segnali stato comparatore
          StatoCmp: out  STD_LOGIC;
          ---segnali Registro RValx
          EnX: in  STD_LOGIC;
          ---segnali Registro RX_A
          EnRx: in  STD_LOGIC;
          SendRx: in  STD_LOGIC
  
  
  
  );
end NodoA_Po;

architecture structural of NodoA_Po is
component MemoriaA is
    generic(
            DataLen: natural :=7
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

component RegistroValx is
   generic(N: natural:=7);
	port(
		ClockRx: in std_logic;
		ReadRx: in std_logic;
		OutToCmp: out std_logic_vector(N downto 0);
		OutRx: out std_logic_vector(N downto 0)
	);
end component;


component RegistroA is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

component comparatore is
    generic(N:natural:=8);
    Port (
        input_1 : in std_logic_vector(N-1 downto 0);
        input_2 : in std_logic_vector(N-1 downto 0);
        output : out std_logic --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end component;

signal OutMem: std_logic_vector(7 downto 0);
signal OutX,InCmp: std_logic_vector(7 downto 0);
begin

MemoriaAa: MemoriaA 
    
    Port map(
		  ClkIn=>ClkA,
		  RstIn=>RstA,
		  EnRead=>EnRead,
		  EndRead=>FineLett,
		  cnt=>EnAddr,
		  OutData=>OutMem
		);

ValX: RegistroValx 
   
	port map(
		ClockRx=>ClkA,
		ReadRx=>EnX,
		OutToCmp=>InCmp,
		OutRx=>OutX
	);
OutFromX<=OutX;
RX: RegistroA 
	port map(
		ClockRx=>ClkA, 
		ResetRx=>RstA,
		InRx=>OutMem,
		WriteRx=>EnRx,
		ReadRx=>SendRx,
		OutRx=>OutFromA
	);


CMP: comparatore 
    
    Port map (
        input_1 =>OutMem,
        input_2 =>InCmp,
        output =>StatoCmp --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );


end structural;
