library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReteComplessiva is
Port ( 
    CLKA: in std_logic:='0';
    CLKB: in std_logic:='0';
    RSTA: in std_logic:='0';
    RSTB: in std_logic:='0';
    START: in std_logic:='0'
  );
end ReteComplessiva;

architecture structural of ReteComplessiva is
component NodoA is
generic (N:integer:=5);
 Port ( 
        ClkA: in std_logic;
        RstA: in std_logic := '0';
        StrtA: in std_logic;
        --protocollo hanshake 
        ReqA: out std_logic;
        OkB: in std_logic := '0';
        --uscita
         OutA: out std_logic_vector(N downto 0)
		 
);
end component;

component NodoB is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        InFromA:in std_logic_vector(N downto 0):="000000";
       --handshake
        ReqA: in std_logic;
        OkA: out std_logic := '0'
   );
end component;
 signal OutATmp:  std_logic_vector(5 downto 0);
 signal ReqATmp,OkBTmp : std_logic:='0';
begin
ComponenteA: NodoA 
 Port map ( 
        ClkA =>CLKA,
        RstA =>RSTA,
        StrtA =>START,
        --protocollo hanshake 
        ReqA =>ReqATmp,
        OkB =>OkBTmp,
        --uscita
         OutA =>OutATmp
		 
);
ComponenteB:  NodoB 
 
  Port map (
        ClockB =>CLKB,
        ResetB=>RSTB,
        InFromA=>OutATmp,
       --handshake
        ReqA =>ReqATmp,
        OkA =>OkBTmp
   );
end structural;
