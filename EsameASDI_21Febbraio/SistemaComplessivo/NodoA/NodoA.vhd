library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity NodoA is
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
end NodoA;

architecture structural of NodoA is
component  NodoAPo is
generic (N: natural := 5);
    Port ( 
        ClockA: in std_logic;
        ResetA: in std_logic;
        ---sengali registro Tx
        EnTx:in std_logic;
        SendTx:in std_logic;
        ---sengali registro Rx
        EnAddr :in std_logic;
        EnRead:in std_logic;
        EndRead:out std_logic:= '0';
        OUT_FROM_A : out std_logic_vector(N downto 0) := "000000"
    );
end component;

component NodoA_Pc is
  Port ( 
    ClockA: in std_logic;
    ResetA: in std_logic := '0';
    ResetPO: out std_logic := '0';
    
    StartA: in std_logic;
    --protocollo hanshake 
    ReqA: out std_logic;
    OkB: in std_logic := '0';
    ---segnali parte operativa
          --segnali Memoria
		  EnRead: out STD_LOGIC:= '0';
		  EnAddr: out STD_LOGIC;
		  EndRead: in  STD_LOGIC;
         ---segnali Registro RX_A
          EnTx: out  STD_LOGIC;
          SendTx: out  STD_LOGIC
    
    
  );
end  component;
signal ResetPOTmp,EnTxTmp,SendTxTmp,EnAddrTmp,EnReadTmp,EndReadTmp :std_logic:='0';
begin
 APop:NodoAPo 
    Port map ( 
        ClockA =>ClkA,
        ResetA =>ResetPOTmp,
        ---sengali registro Tx
        EnTx =>EnTxTmp,
        SendTx=> SendTxTmp,
        ---sengali registro Rx
        EnAddr =>EnAddrTmp,
        EnRead =>EnReadTmp,
        EndRead=>EndReadTmp,
        OUT_FROM_A =>OutA
    );
Apcontr: NodoA_Pc 
  Port  map ( 
     ClockA =>ClkA,
     ResetA =>RstA,
     ResetPO =>ResetPOTmp,
    
    StartA =>StrtA,
    --protocollo hanshake 
    ReqA =>ReqA,
    OkB =>OkB,
    ---segnali parte operativa
      --segnali Memoria
	EnRead =>EnReadTmp,
    EnAddr =>EnAddrTmp,
	EndRead=>EndReadTmp,
    ---segnali Registro TX_A
     EnTx =>EnTxTmp,
     SendTx=> SendTxTmp
    
    
  );
end structural;
