library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity NodoB is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        InFromA:in std_logic_vector(N downto 0):="000000";
       --handshake
        ReqA: in std_logic;
        OkA: out std_logic := '0'
   );
end NodoB;

architecture structural of NodoB is
component NodoBPo is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        InFromA:in std_logic_vector(N downto 0):="000000";
        OutS2:out std_logic_vector( 3 downto 0):="0000";
        OutS1:out std_logic_vector( 3 downto 0):="0000";
        --Segnali Mem
        EnWrite: in  STD_LOGIC:='0';
		EndRead: out STD_LOGIC := '0';
		EnAdrr: in STD_LOGIC:='0';
		--Segnali Rx
		WriteRx: in std_logic:='0';
		ReadRx: in std_logic:='0';
		--Segnali Rx1
		WriteS1: in std_logic:='0';
		ReadS1: in std_logic:='0';
		--Segnali Rx2
		WriteS2: in std_logic:='0';
		ReadS2: in std_logic:='0';
		---selettore Mux
		SelMux: in std_logic:='0';
		---selettore Demux
		selDmux :in std_logic:='0'
		
		 
        
   );
end component;

component NodoBPc is
  generic(N:integer:=5);
  Port (
        ClockB:in std_logic:='0';
        ResetB:in std_logic:='0';
        ResetPo:out std_logic:='0';
        OutS2:in std_logic_vector( 3 downto 0):="0000";
        OutS1:in std_logic_vector( 3 downto 0):="0000";
       --handshake
        ReqA: in std_logic;
        OkA: out std_logic := '0';
       
        --Segnali Mem
        EnWrite: out  STD_LOGIC:='0';
		EndRead: in STD_LOGIC := '0';
		EnAdrr: out STD_LOGIC:='0';
		--Segnali Rx
		WriteRx: out std_logic:='0';
		ReadRx: out std_logic:='0';
		--Segnali Rx1
		WriteS1: out std_logic:='0';
		ReadS1: out std_logic:='0';
		--Segnali Rx2
		WriteS2: out std_logic:='0';
		ReadS2: out std_logic:='0';
		---selettore Mux
		SelMux: out std_logic:='0';
		---selettore Demux
		selDmux :out std_logic:='0'
		
		 
        
   );
end component;

signal OutS1Tmp,OutS2Tmp: std_logic_vector( 3 downto 0):="0000";
signal SelDmuxTmp,SelMuxTmp,ResetPoTmp,EnWriteTmp,EndReadTmp,EnAdrrTmp,WriteRxTmp,ReadRxTmp,WriteS1Tmp,ReadS1Tmp,WriteS2Tmp,ReadS2Tmp:std_logic:='0';
begin
BOp  :NodoBPo 
  Port map (
        ClockB =>ClockB,
        ResetB =>ResetPoTmp,
        InFromA =>InFromA,
        OutS2 =>OutS2Tmp,
        OutS1=>OutS1Tmp,
        --Segnali Mem
        EnWrite =>EnWriteTmp,
		EndRead =>EndReadTmp,
		EnAdrr=>EnAdrrTmp,
		--Segnali Rx
		WriteRx =>WriteRxTmp,
		ReadRx =>ReadRxTmp,
		--Segnali Rx1
		WriteS1=>WriteS1Tmp,
		ReadS1 =>ReadS1Tmp,
		--Segnali Rx2
		WriteS2=>WriteS2Tmp,
		ReadS2 =>ReadS2Tmp,
		--segnale Mux
		SelMux =>SelMuxTmp,
		--segnale Dmux
		SelDmux =>SelDmuxTmp
		
		 
        
   );

BPc:NodoBPc 
  
  Port map (
         ClockB =>ClockB,
         ResetB =>ResetB,
         ResetPo=>ResetPoTmp,
         OutS2 =>OutS2Tmp,
         OutS1 =>OutS1Tmp,
       --handshake
        ReqA=>ReqA,
        OkA=>OkA,
       
      --Segnali Mem
        EnWrite =>EnWriteTmp,
		EndRead =>EndReadTmp,
		EnAdrr=>EnAdrrTmp,
		--Segnali Rx
		WriteRx =>WriteRxTmp,
		ReadRx =>ReadRxTmp,
		--Segnali Rx1
		WriteS1=>WriteS1Tmp,
		ReadS1 =>ReadS1Tmp,
		--Segnali Rx2
		WriteS2=>WriteS2Tmp,
		ReadS2 =>ReadS2Tmp,
		--segnale Mux
		SelMux =>SelMuxTmp,
		--segnale Dmux
		SelDmux =>SelDmuxTmp
		
		 
        
   ); 

end structural;
