library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoB is
 port (
              ClkB  : in std_logic:='0';
              RstB  : in std_logic:='0';
              ReqA  : in std_logic:='0';
              OkB   : out std_logic:='0';
              FineB : out std_logic:='0';
              
              ReqB: out std_logic:='0';
              OkC: in std_logic := '0';
              
              InA  : in std_logic_vector (7 downto 0);
              InX  : in std_logic_vector (7 downto 0);
              OutB  : out std_logic_vector (7 downto 0);
              
              OutStrigaFF: out string(1 to 3));
end NodoB;

architecture structural of NodoB is
component NodoBOp is
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
end component;


component NodoBPc1 is
  Port ( 
    ClockB: in std_logic;
    ResetB: in std_logic := '0';
    ResetPO1: out std_logic := '0';
    
    StartB: in std_logic;
    --protocollo hanshake completo
    ReqB: out std_logic:='0';
    OkC: in std_logic := '0';
    
    ---segnali parte operativa
          --segnali Memoria
		  EnRead: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
          --segnali stato comparatore
          StatoCmp: in  STD_LOGIC:='0';
          ---segnali Registro RX_A
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          
           ---segnali Registro ValCostanteFF
           SendStringaFF: out  STD_LOGIC:='0'
    
    
  );
end component;




component NodoBPc is
  Port ( ClockB: in std_logic;
    ResetB: in std_logic := '0';
    ResetPO: out std_logic := '0';
    StartUc1: out std_logic;
    --protocollo hanshake completo
    ReqA: in std_logic:='0';
    OkB: out std_logic := '0';
    FineB: out std_logic := '0';
    ---segnali parte operativa
    
          --segnali Memoria
		  EnWrite: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
          
          ---segnali Registro RX
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          ---segnali Registro ValX
          EnX: out  STD_LOGIC;
          StatoFlgX: in  STD_LOGIC);
end component;


signal  RstPo,RstPo1,RstPo2,EnAddrTmpPo,SendStringaFFtmp,EnAddrTmp1,StartUc1Tmp,RstPoG,EnReadTmp,EnWriteTmp,EnAddrTmp,FineLettTmp,StatoCmpBTmp,StatoFlagXTmp,EnXTmp,SendXTmp,EnTxTmp,SendTxTmp,EnRxTmp,SendRxTmp: std_logic:='0';


begin

EnAddrTmpPo<=EnAddrTmp or EnAddrTmp1;
--RstPo<=RstPo1 or RstPo2;
RstPo<=RstPo1 or RstPo2;

NodoB_Po: NodoBOp 
  Port map ( 
          ClkB=>ClkB,
		  RstB => RstPo,
		  InFromA=>InA,
		  InX =>InX,
		  OutFromB=>OutB,
		  --segnali Memoria
		  EnRead => EnReadTmp,
		  EnWrite => EnWriteTmp,
		  EnAddr => EnAddrTmpPo,
		  FineLett =>FineLettTmp,
          --segnali stato comparatore B
          StatoCmpB=>StatoCmpBTmp,
           ---segnali Registro RValxB
          StatoFlagX=>StatoFlagXTmp,
          
          EnX=>EnXTmp,
          
          
          ---segnali Registro TX_B
          EnTx=>EnTxTmp,
          SendTx=>SendTxTmp,
           ---segnali Registro RX_B
          EnRx=>EnRxTmp,
          SendRx=>SendRxTmp,
           --segnali RegistroValCost
          SendStriga=>SendStringaFFtmp,
          OutStriga=>OutStrigaFF
        
  
  
  );



NodoB_PC: NodoBPc 
  Port map ( 
        ClockB=>ClkB,
        ResetB=> RstB,
        ResetPO=>RstPo1,
        StartUc1=>StartUc1Tmp,
    --protocollo hanshake completo
        ReqA =>ReqA,
        OkB=>OkB,
        FineB=>FineB,
    ---segnali parte operativa
    
          --segnali Memoria
		  EnWrite=> EnWriteTmp,
		  EnAddr=>  EnAddrTmp,
		  FineLett=>FineLettTmp,
          
          
          ---segnali Registro RX
          EnRx=>EnRxTmp,
          SendRx=>SendRxTmp,
          ---segnali Registro ValX
          EnX=>EnXTmp,
          StatoFlgX=>StatoFlagXTmp
          
         
          
          );



NodoB_PC1:NodoBPc1 
  Port map ( 
    ClockB=>ClkB,
    ResetB=> RstB,
    ResetPO1=>RstPo2,
    
    StartB=>StartUc1Tmp,
    --protocollo hanshake completo
    ReqB=>ReqB,
    OkC=>OkC,
    
    ---segnali parte operativa
          --segnali Memoria
		  EnRead=> EnReadTmp,
		  EnAddr=>  EnAddrTmp1,
		  FineLett=>FineLettTmp,
          --segnali stato comparatore
          StatoCmp=>StatoCmpBTmp,
          ---segnali Registro TX_A
          EnRx=>EnTxTmp,
          SendRx=>SendTxTmp,
           --segnali RegistroValFF
          SendStringaFF=>SendStringaFFtmp
    
    
  );








end structural;
