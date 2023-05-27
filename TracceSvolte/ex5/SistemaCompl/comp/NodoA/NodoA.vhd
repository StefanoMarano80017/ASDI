library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NodoA is
   generic(N:integer:=2);
   Port (
    --handshak
        ReqB : in std_logic:='0';
        OKA : out std_logic:='0';
        ClockA: in std_logic:='0';
        ResetA: in std_logic:='0';
        IndiceI: in std_logic_vector(N downto 0):="000";
        ValXn: out std_logic:='0'
);
end NodoA;

architecture strucutural of NodoA is
component NodoAPc is
generic(N:integer:=2);
  Port (
   --handshake
    ReqB : in std_logic:='0';
    OKA : out std_logic:='0';
    ClockA: in std_logic:='0';
    ResetA: in std_logic:='0';
    ResetPo: out std_logic:='0';
    --Reigistro Rx
    EnRx : out std_logic:='0';
    EnSendRx : out std_logic:='0';
    ValRx : in  STD_LOGIC_VECTOR (N downto 0);
    --Reigistro Tx
    EnTx : out std_logic:='0';
    EnSendTx : out std_logic:='0';
    --Contatore
    EnCont: out std_logic:='0';
    Counter : in  STD_LOGIC_VECTOR (N downto 0);
    --ShiftReg
    EnLoad : out std_logic:='0';
    EnShift : out std_logic:='0');
end  component;

component NodoAPo is
  generic(N:integer:=2);
  Port (
    ClockA: in std_logic:='0';
    ResetA: in std_logic:='0';
    IndiceI: in std_logic_vector(N downto 0):="000";
    --Uscita
    ValXn: out std_logic:='0';
    --Reigistro Rx
    EnRx : in std_logic:='0';
    EnSendRx : in std_logic:='0';
    ValRx : out  STD_LOGIC_VECTOR (N downto 0);
    --Reigistro Tx
    EnTx : in std_logic:='0';
    EnSendTx : in std_logic:='0';
    --Contatore
    EnCont: in std_logic:='0';
    Counter : out  STD_LOGIC_VECTOR (N downto 0);
    StopCount : out STD_LOGIC :='0';
    --ShiftReg
    EnLoad : in std_logic:='0';
    EnShift : in std_logic:='0'
    

   );
end component;
signal EnLoadTmp,StopCountTmp,EnShiftTmp,ResetPoTmp,EnRxTmp,EnSendRxTmp,EnTxTmp,EnSendTxTmp,EnContTmp :std_logic:='0';
signal ValRxTmp,CounterTmp :   STD_LOGIC_VECTOR (2 downto 0);
begin

A_ParteControllo:NodoAPc 
  Port map (
  
    ReqB  =>ReqB,
    OKA  =>OKA,
    ClockA =>ClockA,
    ResetA =>ResetA,
    ResetPo =>ResetPoTmp,
    --Reigistro Rx
    EnRx =>EnRxTmp,
    EnSendRx =>EnSendRxTmp,
    ValRx =>ValRxTmp,
    --Reigistro Tx
    EnTx =>EnTxTmp,
    EnSendTx =>EnSendTxTmp,
    --Contatore
    EnCont=>EnContTmp,
    Counter =>CounterTmp,
    --ShiftReg
    EnLoad=>EnLoadTmp,
    EnShift =>EnShiftTmp);

A_ParteOp:NodoAPo   
    Port map (
    ClockA =>ClockA,
    ResetA =>ResetPoTmp,
    IndiceI =>IndiceI,
    --Uscita
    ValXn=>ValXn,
    --Reigistro Rx
    EnRx =>EnRxTmp,
    EnSendRx =>EnSendRxTmp,
    ValRx =>ValRxTmp,
    --Reigistro Tx
    EnTx =>EnTxTmp,
    EnSendTx =>EnSendTxTmp,
    --Contatore
    EnCont=>EnContTmp,
    Counter =>CounterTmp,
    StopCount => StopCountTmp,
    --ShiftReg
     EnLoad=>EnLoadTmp,
   EnShift =>EnShiftTmp
    

   );
end strucutural;
