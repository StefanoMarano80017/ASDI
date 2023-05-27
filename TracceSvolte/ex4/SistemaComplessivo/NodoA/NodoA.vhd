library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoA is
generic (N:integer:=7);
 Port ( 
        ClkA: in std_logic;
        RstA: in std_logic := '0';
        StrtA: in std_logic;
        --protocollo hanshake completo
        ReqA: out std_logic;
        OkB: in std_logic := '0';
        FineB: in std_logic := '0';
        --uscite
         OutA: out std_logic_vector(N downto 0);
		 OutX: out std_logic_vector(N downto 0)
);
end NodoA;

architecture structural of NodoA is
component NodoA_Po is
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
end component;
component NodoA_Pc is
  Port ( 
    ClockA: in std_logic;
    ResetA: in std_logic := '0';
    ResetPO: out std_logic := '0';
    
    StartA: in std_logic;
    --protocollo hanshake completo
    ReqA: out std_logic;
    OkB: in std_logic := '0';
    FineB: in std_logic := '0';
    ---segnali parte operativa
          --segnali Memoria
		  EnRead: out STD_LOGIC;
		  EnAddr: out STD_LOGIC;
		  FineLett: in  STD_LOGIC;
          --segnali stato comparatore
          StatoCmp: in  STD_LOGIC;
          ---segnali Registro RValx
          EnX: out  STD_LOGIC;
          ---segnali Registro RX_A
          EnRx: out  STD_LOGIC;
          SendRx: out  STD_LOGIC
  );
end component;
signal  RstTmp,tmpRead,tmpAddr,tmpFineLett,tmpCmp,tmpX,tmpRx,tmpSndRx: std_logic:='0';
begin
ParteOperativa:NodoA_Po 
  Port map ( 
          ClkA =>ClkA,
		  RstA =>RstTmp,
		  OutFromA=>OutA,
		  OutFromX=>OutX,
		  --segnali Memoria
		  EnRead =>tmpRead,
		  EnAddr =>tmpAddr,
		  FineLett=>tmpFineLett,
          --segnali stato comparatore
          StatoCmp=>tmpCmp,
          ---segnali Registro RValx
          EnX=>tmpX,
          ---segnali Registro RX_A
          EnRx=>tmpRx,
          SendRx=>tmpSndRx
 );
ParteControllo:NodoA_Pc 
  Port map ( 
    ClockA =>ClkA,
    ResetA=>RstA,
    ResetPO=>RstTmp,
    
    StartA=> StrtA,
    --protocollo hanshake completo
    ReqA=>ReqA,
    OkB=>OkB,
    FineB=>FineB,
    ---segnali parte operativa
          --segnali Memoria
		  EnRead=>tmpRead,
		  EnAddr=>tmpAddr,
		  FineLett=>tmpFineLett,
          --segnali stato comparatore
          StatoCmp=>tmpCmp,
          ---segnali Registro RValx
          EnX=>tmpX,
          ---segnali Registro RX_A
          EnRx=>tmpRx,
          SendRx=>tmpSndRx
  );
end structural;
