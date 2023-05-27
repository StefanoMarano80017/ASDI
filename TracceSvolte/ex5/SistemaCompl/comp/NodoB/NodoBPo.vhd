library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoBPo is
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
end NodoBPo;

architecture structural of NodoBPo is
signal OutTxTmp:  std_logic_vector(2 downto 0);

component RegistroB is
   generic(N: natural:=2);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

component RegistroB1 is
  
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic:='0';
		WriteRx: in std_logic:='0';
		ReadRx: in std_logic:='0';
		OutRx: out std_logic:='0'
	);
end component;
component ContModN is
    generic(
        N:natural:=2
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC :='0'
           );
           
end component;
component ContModNGn is
    generic(
        N:natural:=2
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC :='0'
           );
           
end component;
begin
RegistroTx:  RegistroB 
	port map(
		ClockRx =>ClockB,
		ResetRx=> ResetB,
		InRx => IUtente,
		WriteRx=>EnTx,
		ReadRx=>EnSendTx,
		OutRx=>ValTx
	);

RegistroRx:  RegistroB1 
	port map(
		ClockRx =>ClockB,
		ResetRx=> ResetB,
		InRx =>  ValRx,
		WriteRx=>EnRx,
		ReadRx=>EnSendRx,
		OutRx=>OutValRx
	);
ContatoreDegli1:ContModN 
    Port map ( 
           clock =>ClockB,
           reset => ResetB,
           enable =>EnCont1 , --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter => Counter1,
           stopCount => StopCount1
           );


ContGenerale:ContModNGn 
    Port map ( 
           clock =>ClockB,
           reset => ResetB,
           enable =>EnContG, --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter => CounterG,
           stopCount => StopCountG
           );
end structural;
