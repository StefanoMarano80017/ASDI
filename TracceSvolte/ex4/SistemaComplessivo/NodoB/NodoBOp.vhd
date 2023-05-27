library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoBOp is
 generic (N:integer:=7);
  Port ( 
          ClkB:in STD_LOGIC:='0';
		  RstB: in STD_LOGIC:='0';
		  InFromA: in std_logic_vector(N downto 0);
		  InX: in std_logic_vector(N downto 0);
		  OutFromB: out std_logic_vector(N downto 0);
		  --segnali Memoria
		  EnRead: in STD_LOGIC:='0';
		  EnWrite: in STD_LOGIC:='0';
		  EnAddr: in STD_LOGIC:='0';
		  FineLett: out  STD_LOGIC:='0';
          --segnali stato comparatore B
          StatoCmpB: out  STD_LOGIC:='0';
           
          
          ---segnali Registro RValxB
          EnX: in  STD_LOGIC:='0';
          StatoFlagX: out  STD_LOGIC:='0';
          
          
          ---segnali Registro TX_B
          EnTx: in  STD_LOGIC:='0';
          SendTx: in  STD_LOGIC:='0';
           ---segnali Registro RX_B
          EnRx: in  STD_LOGIC:='0';
          SendRx: in  STD_LOGIC:='0';
          
          --segnali RegistroValCost
          SendStriga: in  STD_LOGIC:='0';
          OutStriga: out string(1 to 3)
          
          
          
        
  
  
  );
end NodoBOp;

architecture structural of NodoBOp is


component Memoria is
    generic(
            DataLen: natural :=7
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
end component;

component comparatoreB is
    generic(N:natural:=8);
    Port (
        input_1 : in std_logic:='0';
        input_2 : in std_logic:='0';
        output : out std_logic :='0'--uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end component;




component Registro is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic:='0';
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic:='0';
		ReadRx: in std_logic:='0';
		OutRx: out std_logic_vector(N downto 0)
	);
end component;
component RegistroValxB is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic:='0';
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic:='0';
		FlagX: out std_logic:='0'
	);
end component;


component RegistroValCost is
   generic(N: natural:=3);
	port(
		ClockRx: in std_logic;
		ReadRx: in std_logic;
		--OutToCmp: out std_logic_vector(N downto 0);
		OutRx: out string(1 to 3)
	);
end component;






signal dataInTmp,dataOutTmp,OutX :  std_logic_vector(7 downto 0);

begin

MemoriaB: Memoria 

port map(
    ClkIn => ClkB,
    RstIn =>RstB, 
    EnRead =>EnRead,
    EnWrite =>EnWrite,
    EndRead=>FineLett,
    cnt=>EnAddr,
    InData =>dataInTmp,
    OutData =>dataOutTmp
    );

CompB: comparatoreB 
    Port map (
        input_1 =>dataOutTmp(N),
        input_2 =>'1',
        output=>StatoCmpB --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
     );



RegistroValx:RegistroValxB 
  
	port map(
		ClockRx=> ClkB,
		 ResetRx=>RstB,
		InRx =>InX,
		WriteRx=>EnX,
		FlagX=>StatoFlagX
	);


Rx_B: Registro  	
      port map(
		ClockRx=> ClkB, 
		ResetRx=>RstB,
		InRx=>InFromA,
		WriteRx=>EnRx,
		ReadRx =>SendRx,
		OutRx=>dataInTmp
	);

Tx_B: Registro  	
      port map(
		ClockRx=> ClkB, 
		ResetRx=>RstB,
		InRx=>dataOutTmp,
		WriteRx=>EnTx,
		ReadRx =>SendTx,
		OutRx=>OutFromB
	);
	
	

RegistroFF:RegistroValCost 
	port map(
		ClockRx=> ClkB, 
		ReadRx=>SendStriga,
		
		OutRx=>OutStriga
	);






end structural;
