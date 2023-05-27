library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoC is
port (
              ClockC  : in std_logic:='0';
              RstC  : in std_logic:='0';
              ReqB: in std_logic:='0';
              OkC: out std_logic := '0';
              InStrFF: in string(1 to 3);
              InB  : in std_logic_vector (7 downto 0));
end NodoC;

architecture structural of NodoC is
component NodoC_Po is
 generic (N:integer:=7);
  Port ( 
          ClkC:in STD_LOGIC;
		  RstC: in STD_LOGIC;
		  InFromB: in std_logic_vector(N downto 0);
		  InXBStr: in string(1 to 3);
		  --segnali Memoria
		  EnWriteMem: in STD_LOGIC;
		  EnAddr: in STD_LOGIC;
		  FineLett: out  STD_LOGIC;
          ---segnali Registro RX_C
          EnRx: in  STD_LOGIC;
          SendRx: in  STD_LOGIC;
           ---segnali Registro REGISTRO_STRINGA
	      FlagStringaFF: out std_logic;
          WriteRStr: in std_logic);
         

end component;



component NodoC_Pc is
  Port ( 
        ClockC: in std_logic;
        ResetC: in std_logic := '0';
        ResetPO: out std_logic := '0';
        --protocollo hanshake completo
        ReqB: in std_logic:='0';
        OkC: out std_logic := '0';
        ---segnali parte operativa
        --segnali Memoria
		  EnWrite: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC:='0';
		  FineLett: in  STD_LOGIC:='0';
         ---segnali Registro RX
          EnRx: out  STD_LOGIC:='0';
          SendRx: out  STD_LOGIC:='0';
          ---segnali Registro ValX
          FlagStringa: in STD_LOGIC:='0';
          EnRStr: out  STD_LOGIC:='0');
end component;





signal RstPo,WriteRStrTmp,FlagStringaFFTmp,EnWriteMemTmp,EnAddrTmp,FineLettTmp,EnRxTmp,SendRxTmp: std_logic:='0';
begin
NodoCPo:NodoC_Po 
  Port map ( 
          ClkC =>ClockC,
		  RstC=>RstPo,
		  InFromB =>InB,
		  InXBStr =>InStrFF,
		  --segnali Memoria
		  EnWriteMem=>EnWriteMemTmp,
		  EnAddr=>EnAddrTmp,
		  FineLett =>FineLettTmp,
          ---segnali Registro RX_C
          EnRx=>EnRxTmp,
          SendRx=>SendRxTmp,
           ---segnali Registro REGISTRO_STRINGA
	      FlagStringaFF =>FlagStringaFFTmp,
          WriteRStr =>WriteRStrTmp);


NodoCPc:NodoC_Pc 
  Port  map( 
        ClockC=>ClockC,
        ResetC=>RstC,
        ResetPO=>RstPo,
        --protocollo hanshake completo
        ReqB =>ReqB,
        OkC=>OkC,
        ---segnali parte operativa
        --segnali Memoria
		  EnWrite=>EnWriteMemTmp,
		  EnAddr=>EnAddrTmp,
		  FineLett=>FineLettTmp,
         ---segnali Registro RX
          EnRx=>EnRxTmp,
          SendRx=>SendRxTmp,
          ---segnali Registro ValX
          FlagStringa=>FlagStringaFFTmp,
          EnRStr=>WriteRStrTmp);
end structural;
