library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SistemaComplessivo is
  Port ( 
            Start,ClockA,ClockB,ClockC,Reset :in std_logic:='0'
  );
end SistemaComplessivo;

architecture strucutural of SistemaComplessivo is
component NodoA is
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
end component;
signal OkBtmp,ReqAtmp,FineBtmp,ReqBTmp,OkCTmp: std_logic:='0';
signal   OutBtmp,OutAtmp,OutXtmp:  std_logic_vector(7 downto 0);
signal  OutStrigaFFtmp:  string(1 to 3);
component NodoB is
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
end component;
component NodoC is
port (
              ClockC  : in std_logic:='0';
              RstC  : in std_logic:='0';
              ReqB: in std_logic:='0';
              OkC: out std_logic := '0';
              InStrFF: in string(1 to 3);
              InB  : in std_logic_vector (7 downto 0));
end component;
begin
ComponenteA: NodoA 
 Port map ( 
        ClkA =>ClockA,
        RstA=>Reset,
        StrtA=>Start,
        --protocollo hanshake completo
        ReqA =>ReqAtmp,
        OkB=>OkBtmp,
        FineB=>FineBtmp,
        --uscite
         OutA=>OutAtmp,
		 OutX=>OutXtmp
);

ComponenteB: NodoB 
 port map (
              ClkB  =>ClockB,
              RstB  =>Reset,
              ReqA  =>ReqAtmp,
              OkB   =>OkBtmp,
              FineB =>FineBtmp,
              
              ReqB =>ReqBTmp,
              OkC=>OkCTmp,
              
              InA=>OutAtmp,
              InX=>OutXtmp,
              OutB =>OutBtmp,
              
              OutStrigaFF=> OutStrigaFFtmp);


ComponenteC: NodoC 
port  map(
              ClockC =>ClockC,
              RstC =>Reset,
              ReqB=>ReqBTmp,
              OkC=>OkCTmp,
              InStrFF=> OutStrigaFFtmp,
              InB  =>OutBtmp
          );









end strucutural;
