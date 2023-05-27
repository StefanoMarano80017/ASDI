library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NodoBPo is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        InFromA:in std_logic_vector(N downto 0):="000000";
        OutS2:out std_logic_vector( 3 downto 0):="0000";
        OutS1:out std_logic_vector( 3 downto 0):="0000";
        --Segnali Mem
        EnWrite: in  STD_LOGIC:='0';
		EndRead: out STD_LOGIC := '0';
		EnAdrr: in STD_LOGIC:='0';
		--Segnali Rx
		WriteRx: in std_logic:='0';
		ReadRx: in std_logic:='0';
		--Segnali Rx1
		WriteS1: in std_logic:='0';
		ReadS1: in std_logic:='0';
		--Segnali Rx2
		WriteS2: in std_logic:='0';
		ReadS2: in std_logic:='0';
		---selettore Mux
		SelMux: in std_logic:='0'
		
		 
        
   );
end NodoBPo;

architecture strucutural of NodoBPo is
component MacchSottr is
generic(
    N : integer := 4
    );
  Port ( 
    A :in std_logic_vector(N-1 downto 0):="0000";
    B1 :in std_logic_vector(N-3 downto 0):="00";
    S: out std_logic_vector(N-1 downto 0):="0000";
    C_in: in std_logic:='0';
    C_out: out std_logic:='0'
  );
end component;


component  Memoria is
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
 end component;
 
 
component RegistroS1 is
   generic(N: natural:=3);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end  component;


component RegistroS2 is
   generic(N: natural:=1);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end  component;

component  mux_2_1 is
   generic( N:integer:=3);
    Port ( a0 : in STD_LOGIC_VECTOR(N downto 0);
           a1 : in STD_LOGIC_VECTOR(N downto 0);
           s : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(N downto 0));

end component; 
 
 



signal OutRxTmp:  std_logic_vector(5 downto 0);
signal OutS1Tmp:  std_logic_vector(3 downto 0);
signal OutS2Tmp:  std_logic_vector(1 downto 0);

signal S1Tmp,S1FromRxTmp,S1FromSottrTmp:  std_logic_vector(3 downto 0);
signal S2Tmp,Tmp0,S2FromRxTmp:  std_logic_vector(1 downto 0):="00";

signal C_inTmp,C_outTmp: std_logic:='0';
signal  OutDataTmp:   std_logic_vector(3 downto 0):="0000";
begin

Rx :RegistroB 
	port map(
		ClockRx =>ClockB,
		ResetRx=>ResetB,
		InRx =>InFromA,
		WriteRx =>WriteRx,
		ReadRx => ReadRx,
		OutRx=>OutRxTmp
 );
S1FromRxTmp<=OutRxTmp(2) & OutRxTmp(3) & OutRxTmp(4) & OutRxTmp(5);
S2FromRxTmp<=OutRxTmp(3) & OutRxTmp(2);

--S1Tmp<= not(S1FromRxTmp) or  not(S1FromSottrTmp);



OutS2<="00"&S2FromRxTmp;
OutS1<=S1FromSottrTmp;

RS1:RegistroS1 
  
	port map(
		ClockRx =>ClockB,
		ResetRx=>ResetB,
		InRx =>S1Tmp,
		WriteRx =>WriteS1,
		ReadRx => ReadS1,
		OutRx=>OutS1Tmp
 );
 
 
Mux: mux_2_1 
    Port map ( 
           a0 =>S1FromRxTmp,
           a1 =>S1FromSottrTmp,
           s =>SelMux,
           y =>S1Tmp);

 

RS2:RegistroS2 
  
	port map(
		ClockRx =>ClockB,
		ResetRx=>ResetB,
		InRx =>S2FromRxTmp,
		WriteRx =>WriteS2,
		ReadRx => ReadS2,
		OutRx=>OutS2Tmp
 );
 
 
 Sottrattore :  MacchSottr 
  Port map ( 
    A =>OutS1Tmp,
    B1 =>OutS2Tmp,
    S => S1FromSottrTmp,
    C_in =>C_inTmp,
    C_out =>C_outTmp
  );
 
MemB:Memoria 
    Port map(
		  ClkIn=>ClockB,
		  RstIn=>ResetB,
		  EnRead =>'0',
		  EnWrite =>EnWrite,
		  EndRead =>EndRead,
		  cnt => EnAdrr,
		  InData =>OutS1Tmp,
		  OutData =>OutDataTmp
		);




end strucutural;