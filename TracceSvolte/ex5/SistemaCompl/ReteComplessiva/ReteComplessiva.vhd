
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ReteComplessiva is
  Port ( 
    ClockA: in std_logic:='0';
    ClockB: in std_logic:='0';
    ResetA: in std_logic:='0';
    ResetB: in std_logic:='0';
    StartB: in std_logic:='0';
    InUtente: in std_logic_vector(2 downto 0):="000"
  );
end ReteComplessiva;

architecture strucutural of ReteComplessiva is
component NodoA is
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
end component;

component NodoB is
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
end component;
signal ReqBTmp,OKATmp,ValXnTmp:std_logic:='0';
signal IndiceITmp:  std_logic_vector(2 downto 0):="000";
begin
CompA:NodoA 
   
   Port map (
    --handshak
        ReqB =>ReqBTmp,
        OKA =>OKATmp,
        ClockA =>ClockA,
        ResetA=>ResetA,
        IndiceI=>IndiceITmp,
        ValXn=>ValXnTmp
);
 CompB:NodoB 
   Port map (
   --handshake
    ReqA =>ReqBTmp,
    OKA =>OKATmp,
    --handshake
    StartB=>StartB,
    ClockB =>ClockB,
    ResetB=>ResetB,
    IUtente=>InUtente,
    IndiceI=>IndiceITmp,
    ValXn=>ValXnTmp
);
end strucutural;
