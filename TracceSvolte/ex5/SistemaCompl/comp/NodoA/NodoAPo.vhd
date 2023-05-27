library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity NodoAPo is
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
end NodoAPo;

architecture structural of NodoAPo is
component ShiftRegRing is
  port(
        clk  : in std_logic;
        load :in std_logic;
        enSh: in std_logic;
        d : in std_logic_vector (0 to 3);
        q : inout std_logic_vector (0 to 3);
        qout : out std_logic:='0');
 
end component;
component ContModNA is
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
signal qoutTmp :  std_logic:='0';
signal qtmp:  std_logic_vector(3 downto 0);
begin

ShRIng:ShiftRegRing 
    port map (
        clk=>ClockA,
        load =>EnLoad,
         enSh=>EnShift,
        d =>"1010",
        q =>qtmp,
        qout =>qoutTmp);
 
ContatoreI: ContModNA 
  
    Port  map ( clock =>ClockA,
           reset => ResetA,
           enable  => EnCont, --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter =>Counter ,
           stopCount => StopCount 
           ); 

Rx:RegistroB 
	port map(
		ClockRx =>ClockA,
		ResetRx=> ResetA,
		InRx =>IndiceI,
		WriteRx => EnRx,
		ReadRx => EnSendRx,
		OutRx =>ValRx
	);

Tx:RegistroB1 
	port map(
		ClockRx =>ClockA,
		ResetRx=> '0',
		InRx =>qoutTmp,
		WriteRx => EnTx,
		ReadRx => EnSendTx,
		OutRx =>ValXn
	);
end structural;
