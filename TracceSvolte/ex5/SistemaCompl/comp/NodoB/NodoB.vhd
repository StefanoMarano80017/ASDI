library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoB is
 generic(N:integer:=2);
   Port (
   --handshake
    ReqA : out std_logic:='0';
    OKA : in std_logic:='0';
    --handshake
    StartB: in std_logic:='0';
    ClockB: in std_logic:='0';
    ResetB: in std_logic:='0';
    IUtente: in std_logic_vector(N downto 0):="000";
    IndiceI: out std_logic_vector(N downto 0):="000";
    ValXn: in std_logic:='0'
);
end NodoB;

architecture structural of NodoB is
component  NodoBPo is
generic(N:integer:=2);
  Port (
    ClockB: in std_logic:='0';
    ResetB: in std_logic:='0';
    IUtente: in std_logic_vector(N downto 0):="000";
  
    --Reigistro Rx
    EnRx : in std_logic:='0';
    EnSendRx : in std_logic:='0';
    ValRx : in  std_logic:='0';
    OutValRx : out  std_logic:='0';
    --Reigistro Tx
    EnTx : in std_logic:='0';
    EnSendTx : in std_logic:='0';
    ValTx : out  STD_LOGIC_VECTOR (N downto 0);
    
    --Contatore Generale per numero di invii
    EnContG: in std_logic:='0';
    CounterG : out  STD_LOGIC_VECTOR (N downto 0);
    StopCountG : out STD_LOGIC :='0';
     --Contatore numero 1 ricevuti
    EnCont1: in std_logic:='0';
    Counter1 : out  STD_LOGIC_VECTOR (N downto 0);
    StopCount1 : out STD_LOGIC :='0'
    
    

   );
end  component;

component NodoBPc is
generic(N:integer:=2);
  Port (
    --handshake
    ReqA : out std_logic:='0';
    OKA : in std_logic:='0';
    --handshake
    Start: in std_logic:='0';
    ClockB: in std_logic:='0';
    ResetB: in std_logic:='0';
    ResetPo: out std_logic:='0';
     --Reigistro Rx
    EnRx : out std_logic:='0';
    EnSendRx : out std_logic:='0';
    OutValRx : in  std_logic:='0';
    --Reigistro Tx
    EnTx : out std_logic:='0';
    EnSendTx : out std_logic:='0';
    --Contatore Generale per numero di invii
    EnContG: out std_logic:='0';
    StopCountG : in STD_LOGIC :='0';
     --Contatore numero 1 ricevuti
    EnCont1: out std_logic:='0'
    );
end component;
signal ResetPoTmp,StopCount1Tmp,OutValRxTmp,EnCont1Tmp,StopCountGTmp,EnRxTmp,EnSendRxTmp,EnTxTmp,EnSendTxTmp,EnContGTmp: std_logic:='0';
signal  CounterGTmp,Counter1Tmp :   STD_LOGIC_VECTOR (2 downto 0);
begin
BParteOp: NodoBPo 

  Port map (
    ClockB =>ClockB,
    ResetB => ResetPoTmp,
    IUtente => IUtente,
  
    --Reigistro Rx
    EnRx =>EnRxTmp,
    EnSendRx =>EnSendRxTmp,
    ValRx =>ValXn,
    OutValRx =>OutValRxTmp,
    --Reigistro Tx
    EnTx =>EnTxTmp,
    EnSendTx =>EnSendTxTmp,
    ValTx =>IndiceI,
    
    --Contatore Generale per numero di invii
    EnContG=>EnContGTmp,
    CounterG =>CounterGTmp,
    StopCountG=>StopCountGTmp,
     --Contatore numero 1 ricevuti
    EnCont1=>EnCont1Tmp,
    Counter1 =>Counter1Tmp,
    StopCount1 =>StopCount1Tmp
);

BParteContr:NodoBPc 
  Port map (
    --handshake
    ReqA =>ReqA,
    OKA =>OKA,
    --handshake
    Start=>StartB,
   ClockB =>ClockB,
    ResetB => ResetB,
    ResetPo=>ResetPoTmp,
     --Reigistro Rx
    EnRx =>EnRxTmp,
    EnSendRx =>EnSendRxTmp,
    OutValRx =>OutValRxTmp,
    --Reigistro Tx
     EnTx =>EnTxTmp,
    EnSendTx =>EnSendTxTmp,
    --Contatore Generale per numero di invii
     EnContG=>EnContGTmp,
    StopCountG=>StopCountGTmp,
     --Contatore numero 1 ricevuti
     EnCont1=>EnCont1Tmp
    );

end structural;
