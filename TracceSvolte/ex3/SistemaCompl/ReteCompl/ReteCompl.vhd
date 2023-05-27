library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ReteCompl is
  Port ( 
    CLKA: in std_logic:='0';
    CLKB: in std_logic:='0';
    RSTA: in std_logic:='0';
    RSTB: in std_logic:='0';
    START: in std_logic:='0'
  );
end ReteCompl;

architecture strucrural of ReteCompl is
component NodoA is
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
end component;

component NodoB is
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
end component;


signal OutSerialBTmp,ReqATmp,OKBTmp,ReqBTmp,OKATmp:std_logic:='0'; 
signal OutS1Tmp,OutS2Tmp:  std_logic_vector(7 downto 0);
signal OutCodTmp:  std_logic_vector(1 downto 0);
begin




A:NodoA 
 Port map ( 
        --handshake per dati paralleli
        ReqA =>ReqAtmp,
        OKB =>OKBTmp,
        --handshake per dati seriali
        ReqB=>ReqBTmp,
        OKA =>OKATmp,
        
        ClockA =>CLKA,
        ResetA =>RSTA,
        Start =>START,
        OutS1=>OutS1Tmp,
        OutS2=>OutS2Tmp,
        OutCod=>OutCodTmp,
        InSerialB =>OutSerialBTmp
 );

B:NodoB 
 Port map ( 
        --handshake per dati paralleli
        ReqA =>ReqATmp,
        OKB =>OKBTmp,
        --handshake per dati seriali
        ReqB=>ReqBTmp,
        OKA =>OKATmp,
        ClockB =>CLKB,
        ResetB =>RSTB,
        
        InS1=>OutS1Tmp,
        InS2=>OutS2Tmp,
        InCod=>OutCodTmp,
        OutSerialB =>OutSerialBTmp
 ); 

end strucrural;
