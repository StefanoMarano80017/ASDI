library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoA is
generic(N :integer:=7;DimCod :integer:=1);
 Port ( 
        --handshake per dati paralleli
        ReqA : out std_logic:='0';
        OKB : in std_logic:='0';
        --handshake per dati seriali
        ReqB : in std_logic:='0';
        OKA : out std_logic:='0';
        
        ClockA : in std_logic:='0';
        ResetA : in std_logic:='0';
        Start : in std_logic:='0'; 
        OutS1: out std_logic_vector(N downto 0);
        OutS2: out std_logic_vector(N downto 0);
        OutCod: out std_logic_vector(DimCod downto 0);
        InSerialB : in std_logic:='0'
 );
end NodoA;

architecture structural of NodoA is
    component AParteCotr is
        generic(N :integer:=7;DimCod :integer:=1);
    Port ( 
         --handshake per dati paralleli
         ReqA : out std_logic:='0';
         OKB : in std_logic:='0';
         --comunicazione altro process
        InRicezione : in std_logic:='0';
        StartRicezione : out std_logic:='0';
        ClockA : in std_logic:='0';
        ResetA : in std_logic:='0';
        ResetPo : out std_logic:='0';
        Start : in std_logic:='0';
        ---segnali registro S1_Rx
        EnSend1:out std_logic:='0';
        EnRx1:out std_logic:='0';
        ---segnali registro S2_Rx
        EnSend2:out std_logic:='0';
        EnRx2:out std_logic:='0';
        ---segnali registro Cod_Rx
        EnSendCod:out std_logic:='0';
        EnRxCod:out std_logic:='0';
        --sengnale contatore indirizzo Demux
        EnSelect :out std_logic:='0';
        ValoreSelDmux : in  STD_LOGIC_VECTOR (1 downto 0);
        --segnali Memoria
        EnRead: out STD_LOGIC;
        EnAddr: out STD_LOGIC;
        FineLett: in  STD_LOGIC
    );
end component;

component ParteOpA is
  generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    ClockA : in std_logic:='0';
    ResetA : in std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:in std_logic:='0';
    EnRx1:in std_logic:='0';
    OutS1: out std_logic_vector(N downto 0);
    
    ---segnali registro S2_Rx
    EnSend2:in std_logic:='0';
    EnRx2:in std_logic:='0';
    OutS2: out std_logic_vector(N downto 0);
    ---segnali registro Cod_Rx
    EnSendCod:in std_logic:='0';
    EnRxCod:in std_logic:='0';
    OutCod: out std_logic_vector(DimCod downto 0);
    
     ---segnali registro scorrimento Tx
   
    ShiftTx:in std_logic:='0';
    
    OutSerialFromB : in std_logic:='0';
    
    --sengnale contatore Sh
    EnContSh :in std_logic:='0';
    FlagStopSh :out std_logic:='0';
    --sengnale contatore indirizzo Demux
    EnSelect :in std_logic:='0';
    ValSelectDmux :  out STD_LOGIC_VECTOR(1 downto 0);
    --segnali Memoria
    EnRead: in STD_LOGIC;
	EnAddr: in STD_LOGIC;
	FineLett: out  STD_LOGIC
    
  );
end component;



component AParteContr1 is
generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    --handshake
    ReqB : in std_logic:='0';
    OKA : out std_logic:='0';
    --comunicazione altro process
    InRicezione : out std_logic:='0';
    StartRicezione : in std_logic:='0';
    ClockA : in std_logic:='0';
    ResetA : in std_logic:='0';
    ResetPo : out std_logic:='0';
    ---segnali registro scorrimento Tx
    ShiftTx:out std_logic:='0';
    --sengnale contatore Sh
    EnContSh :out std_logic:='0';
    FlagStopSh :in std_logic:='0'
    
    
      );
end component;







signal ResetPo,ResetPo1,ResetPo2,InRicezioneTmp,StartRicezioneTmp :  std_logic:='0';
signal EnSend1Tmp,EnSend2Tmp,EnRx1Tmp,EnRx2Tmp,EnSendCodTmp,EnRxCodTmp,EnSelectTmp :  std_logic:='0';
signal ValoreSelDmuxTmp:STD_LOGIC_VECTOR (1 downto 0);
signal EnReadTmp,EnAddrTmp,FineLettTmp  :  std_logic:='0';
signal  ShiftTxTmp,EnContShTmp,FlagStopShTmp :  std_logic:='0';

begin
ResetPo<=ResetPo1 or ResetPo2;



     
ParteControlloA: AParteCotr 

  Port map ( 
     --handshake per dati paralleli
     ReqA =>ReqA,
     OKB => OKB,
     --comunicazione altro process
    InRicezione =>InRicezioneTmp,
    StartRicezione =>StartRicezioneTmp,
    ClockA  =>ClockA,
    ResetA =>ResetA,
    ResetPo =>ResetPo1,
    Start =>Start,
    ---segnali registro S1_Rx
    EnSend1=>EnSend1Tmp,
    EnRx1=>EnRx1Tmp,
    ---segnali registro S2_Rx
    EnSend2=>EnSend2Tmp,
    EnRx2=>EnRx2Tmp,
    ---segnali registro Cod_Rx
    EnSendCod=>EnSendCodTmp,
    EnRxCod=>EnRxCodTmp,
    --sengnale contatore indirizzo Demux
    EnSelect=> EnSelectTmp,
    ValoreSelDmux =>ValoreSelDmuxTmp,
    --segnali Memoria
    EnRead=>EnReadTmp,
	EnAddr=>EnAddrTmp,
	FineLett=>FineLettTmp
);

ParteOperativaA:ParteOpA 
  
  Port map ( 
    ClockA =>ClockA,
    ResetA =>ResetPo,
    ---segnali registro S1_Rx
    EnSend1=>EnSend1Tmp,
    EnRx1=>EnRx1Tmp,
    OutS1 =>OutS1,
    
    ---segnali registro S2_Rx
    EnSend2=>EnSend2Tmp,
    EnRx2=>EnRx2Tmp,
    OutS2 =>OutS2,
    ---segnali registro Cod_Rx
    EnSendCod =>EnSendCodTmp,
    EnRxCod=>EnRxCodTmp,
    OutCod =>OutCod,
    
     ---segnali registro scorrimento Tx
    
    ShiftTx=>ShiftTxTmp,
    
    OutSerialFromB =>InSerialB,
    
    --sengnale contatore Sh
    EnContSh =>EnContShTmp,
    FlagStopSh =>FlagStopShTmp,
    --sengnale contatore indirizzo Demux
    EnSelect =>EnSelectTmp,
    ValSelectDmux =>ValoreSelDmuxTmp,
    --segnali Memoria
    EnRead =>EnReadTmp,
	EnAddr=>EnAddrTmp,
	FineLett=>FineLettTmp
    
  );



ParteControlloA1:AParteContr1 
  Port map ( 
    --handshake
    ReqB =>ReqB,
    OKA =>OKA,
    --comunicazione altro process
    InRicezione =>InRicezioneTmp,
    StartRicezione=>StartRicezioneTmp,
    ClockA =>ClockA,
    ResetA =>ResetA,
    ResetPo =>ResetPo2,
    ---segnali registro scorrimento Tx
    ShiftTx =>ShiftTxTmp,
    --sengnale contatore Sh
    EnContSh =>EnContShTmp,
    FlagStopSh =>FlagStopShTmp
    
    
      );






end structural;
