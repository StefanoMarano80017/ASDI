library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ParteOpA is
  generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    ClockA : in std_logic:='0';
    ResetA : in std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:in std_logic:='0';
    EnRx1:in std_logic:='0';
    OutS1: out std_logic_vector(N downto 0);
    
    ---segnali registro S2_Rx
    EnSend2:in std_logic:='0';
    EnRx2:in std_logic:='0';
    OutS2: out std_logic_vector(N downto 0);
    ---segnali registro Cod_Rx
    EnSendCod:in std_logic:='0';
    EnRxCod:in std_logic:='0';
    OutCod: out std_logic_vector(DimCod downto 0);
    
     ---segnali registro scorrimento Tx
   
    ShiftTx:in std_logic:='0';
    
    OutSerialFromB : in std_logic:='0';
    
    --sengnale contatore Sh
    EnContSh :in std_logic:='0';
    FlagStopSh :out std_logic:='0';
    --sengnale contatore indirizzo Demux
    EnSelect :in std_logic:='0';
    ValSelectDmux :  out STD_LOGIC_VECTOR(1 downto 0);
    --segnali Memoria
    EnRead: in STD_LOGIC;
	EnAddr: in STD_LOGIC;
	FineLett: out  STD_LOGIC
    
  );
end ParteOpA;

architecture structural of ParteOpA is
component MemoriaA is
    generic(
            DataLen: natural :=7
            );
    Port(
		  ClkIn:      in  STD_LOGIC;
		  RstIn:      in  STD_LOGIC;
		  EnRead:     in  STD_LOGIC;
		  EndRead:    out STD_LOGIC := '0';
		  cnt:        in STD_LOGIC;
		  OutData:    out std_logic_vector(DataLen downto 0)
		);
end component;

component demux_1_3 is
   generic( N:integer:=7);
    Port ( 
	   x : in STD_LOGIC_VECTOR(N downto 0);
	   s : in STD_LOGIC_VECTOR(1 downto 0);
           y0 : out STD_LOGIC_VECTOR(N downto 0);
           y1 : out STD_LOGIC_VECTOR(N downto 0);
	   y2 : out STD_LOGIC_VECTOR(N downto 0)
           );
end component;

component RegistroB is
   generic(N: natural:=7);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

component RegistroB1 is
   generic(N: natural:=1);
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

component  encoder is
Port ( 
	s : out STD_LOGIC_VECTOR (1 downto 0);
	y : in STD_LOGIC_VECTOR (7 downto 0));
end component;


component shift_register is
generic(
    data_len: natural := 7
);
port (
  i_clk          : in  std_logic;
  i_rstb         : in  std_logic;
  i_data         : in  std_logic;
  i_data_par     : in  std_logic_vector(data_len downto 0);
  o_data_par         : out std_logic_vector(data_len downto 0);
  o_data_ser         : out std_logic;
  enable_read        : in std_logic;
  enable_sh          : in std_logic
);
end component;


 component ContModNSh is
    generic(
        N:natural:=3
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
	       enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           --counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount : out STD_LOGIC :='0'
           );
           
end component;


component ContModDmux is
    generic(
        N:natural:=1
    );
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (N downto 0)
           );
           
end component;


signal OutDataMem: std_logic_vector(7 downto 0);
signal valueSelect,OutEncoderTmp :  STD_LOGIC_VECTOR(1 downto 0);
signal  i_data_parTmp, o_data_parTmp     :  std_logic_vector(7 downto 0):="00000000";
signal o_data_serTmp  :std_logic:='0'; 
signal ValS1Tmp,ValS2Tmp,ValCodTmp :  STD_LOGIC_VECTOR(N downto 0);

begin
ValSelectDmux<=valueSelect;
MemA:MemoriaA 
    Port map(
		  ClkIn=>ClockA,
		  RstIn =>ResetA,
		  EnRead=>EnRead,
		  EndRead =>FineLett,
		  cnt=>EnAddr,
		  OutData =>OutDataMem
		);

Demux:demux_1_3 
    Port map ( 
	       x =>OutDataMem,
	       s =>valueSelect,
           y0=>ValS1Tmp,
           y1=>ValS2Tmp,
	       y2=>ValCodTmp
           );



ContDmx:ContModDmux 
    Port map ( 
           clock =>ClockA,
           reset =>ResetA,
		   enable =>EnSelect, --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter=> valueSelect
           );
           




RegistroS1:RegistroB 
	port map(
		ClockRx=>ClockA, 
		ResetRx=>ResetA,
		InRx=>ValS1Tmp,
		WriteRx =>EnRx1,
		ReadRx =>EnSend1,
		OutRx =>OutS1
	);

RegistroS2:RegistroB 
	port map(
		ClockRx=>ClockA, 
		ResetRx=>ResetA,
		InRx=>ValS2Tmp,
		WriteRx =>EnRx2,
		ReadRx =>EnSend2,
		OutRx =>OutS2
	);


Encoder7_2:encoder 
Port map ( 
	y =>ValCodTmp,
	s =>OutEncoderTmp
	
	);






RegistroCod:RegistroB1
	port map(
		ClockRx=>ClockA, 
		ResetRx=>ResetA,
		InRx=>OutEncoderTmp,
		WriteRx =>EnRxCod,
		ReadRx =>EnSendCod,
		OutRx =>OutCod
	);

RxShiftRegister: shift_register 

port map (
    i_clk=>ClockA,
    i_rstb =>ResetA,
    i_data =>OutSerialFromB,
    i_data_par=>i_data_parTmp,
    o_data_ser=>o_data_serTmp,
    o_data_par  =>o_data_parTmp,
    enable_read=>'0',
    enable_sh=>ShiftTx
);

ContShRegister:ContModNSh 
    Port map ( 
           clock =>ClockA,
           reset =>ResetA,
	       enable =>EnContSh, --questo è l'enable del clock, insieme danno l'impulso di conteggio
           --counter : out  STD_LOGIC_VECTOR (N downto 0);
           stopCount =>FlagStopSh
           );

end structural;
