library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoB is
generic(N :integer:=7;DimCod :integer:=1);
 Port ( 
        --handshake per dati paralleli
        ReqA : in std_logic:='0';
        OKB : out std_logic:='0';
        --handshake per dati seriali
       
        ReqB : out std_logic:='0';
        OKA : in std_logic:='0';
        
        ClockB : in std_logic:='0';
        ResetB : in std_logic:='0'; 
        InS1: in std_logic_vector(N downto 0);
        InS2: in std_logic_vector(N downto 0);
        InCod: in std_logic_vector(DimCod downto 0);
        OutSerialB : out std_logic:='0'
 );
end NodoB;

architecture structural of NodoB is
component BParteContr is
 Port ( 
    --handshake
    ReqA : in std_logic:='0';
    OKB : out std_logic:='0';
    --comunicazione altro process
    InTrasmissione : in std_logic:='0';
    StartTrasmissione : out std_logic:='0';
    
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
     ResetPo : out std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:out std_logic:='0';
    EnRx1:out std_logic:='0';
    ---segnali registro S2_Rx
    EnSend2:out std_logic:='0';
    EnRx2:out std_logic:='0';
    ---segnali registro Cod_Rx
    EnSendCod:out std_logic:='0';
    EnRxCod:out std_logic:='0';
    OutCod: in std_logic_vector(1 downto 0);
    --sel demux
    selDMux :out std_logic:='0';
    --sel mux
    selMux :out std_logic:='0';
     ---segnali registro scorrimento Tx
    LoadTx:out std_logic:='0'
    
    
  );
end component;





 component BParteContr1 is
generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    --handshake
    ReqB : out std_logic:='0';
    OKA : in std_logic:='0';
    --comunicazione altro process
    InTrasmissione : out std_logic:='0';
    StartTrasmissione : in std_logic:='0';
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
    ResetPo : out std_logic:='0';
   
    ---segnali registro scorrimento Tx
    ShiftTx:out std_logic:='0';
    DataIn :out std_logic:='0';
  
    --sengnale contatore SH
    EnContSh :out std_logic:='0';
    FlagStopSh :in std_logic:='0'
  );
end component;





component BparteOp is
  generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:in std_logic:='0';
    EnRx1:in std_logic:='0';
    InS1: in std_logic_vector(N downto 0);
    ---segnali registro S2_Rx
    EnSend2:in std_logic:='0';
    EnRx2:in std_logic:='0';
    InS2: in std_logic_vector(N downto 0);
    ---segnali registro Cod_Rx
    EnSendCod:in std_logic:='0';
    EnRxCod:in std_logic:='0';
    InCod: in std_logic_vector(DimCod downto 0);
    OutCod: out std_logic_vector(DimCod downto 0);
    --sel demux
    selDMux :in std_logic:='0';
    --sel mux
    selMux :in std_logic:='0';
     ---segnali registro scorrimento Tx
   
    ShiftTx:in std_logic:='0';
    LoadTx:in std_logic:='0';
    DataIn :in std_logic:='0';
    OutB : out std_logic:='0';
    
  
    --sengnale contatore Somma
    EnContSh :in std_logic:='0';
    FlagStopSh :out std_logic:='0'
  );
end component;
signal EnSendCodTmp,ResetPo,ResetPo1,ResetPo2,EnContShTmp,FlagStopShTmp,ShiftTxTmp,DataInTmp,EnSend2Tmp,EnSend1Tmp,LoadTxTmp,selDMuxTmp,selMuxTmp,EnRxCodTmp,EnRx1Tmp,EnRx2Tmp,InTrasmissioneTmp,StartTrasmissioneTmp:std_logic:='0';
signal OutCodTmp:  std_logic_vector(1 downto 0);

begin
ResetPo<=ResetPo1 or ResetPo2;


ParteControlloB:BParteContr 
 Port map ( 
    --handshake
    ReqA =>ReqA,
    OKB =>OKB,
    --comunicazione altro process
    InTrasmissione =>InTrasmissioneTmp,
    StartTrasmissione =>StartTrasmissioneTmp,
    ClockB =>ClockB,
    ResetB =>ResetB,
    ResetPo =>ResetPo1,
    ---segnali registro S1_Rx
    EnSend1=>EnSend1Tmp,
    EnRx1 =>EnRx1Tmp,
    ---segnali registro S2_Rx
    EnSend2=>EnSend2Tmp,
    EnRx2 =>EnRx2Tmp,
    ---segnali registro Cod_Rx
    EnSendCod=>EnSendCodTmp,
    EnRxCod=>EnRxCodTmp,
    OutCod =>OutCodTmp,
    --sel demux
    selDMux=>selDMuxTmp,
    --sel mux
    selMux=>selMuxTmp,
     ---segnali registro scorrimento Tx
    LoadTx=>LoadTxTmp
    
    
  );



ParteOperativaB:BparteOp 
    Port map ( 
        ClockB =>ClockB,
        ResetB =>ResetPo,
    ---segnali registro S1_Rx
        EnSend1 =>EnSend1Tmp,
        EnRx1 =>EnRx1Tmp,
        InS1=>InS1,
    ---segnali registro S2_Rx
    EnSend2=>EnSend2Tmp,
    EnRx2=>EnRx2Tmp,
    InS2=>InS2,
    ---segnali registro Cod_Rx
    EnSendCod =>EnSendCodTmp,
    EnRxCod =>EnRxCodTmp,
    InCod =>InCod,
    OutCod =>OutCodTmp,
    --sel demux
    selDMux=>selDMuxTmp,
    --sel mux
    selMux =>selMuxTmp,
     ---segnali registro scorrimento Tx
   
    ShiftTx=>ShiftTxTmp,
    LoadTx=>LoadTxTmp,
    DataIn =>DataInTmp,
    OutB =>OutSerialB,
    
   
    --sengnale contatore Somma
    EnContSh=>EnContShTmp,
    FlagStopSh =>FlagStopShTmp
  );


ParteControlloB1:BParteContr1 
  Port map ( 
    --handshake
    ReqB =>ReqB,
    OKA =>OKA,
    --comunicazione altro process
    InTrasmissione =>InTrasmissioneTmp,
    StartTrasmissione =>StartTrasmissioneTmp,
    ClockB =>ClockB,
    ResetB =>ResetB,
    ResetPo => ResetPo2,
    
 
    ---segnali registro scorrimento Tx
    ShiftTx =>ShiftTxTmp,
    DataIn =>DataInTmp,
    
    --sengnale contatore Sh
    EnContSh =>EnContShTmp,
    FlagStopSh =>FlagStopShTmp
  );







end structural;
