
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity BparteOp is
  generic(N :integer:=7;DimCod :integer:=1);
  Port ( 
    ClockB : in std_logic:='0';
    ResetB : in std_logic:='0';
    ---segnali registro S1_Rx
    EnSend1:in std_logic:='0';
    EnRx1:in std_logic:='0';
    InS1: in std_logic_vector(N downto 0);
    ---segnali registro S2_Rx
    EnSend2:in std_logic:='0';
    EnRx2:in std_logic:='0';
    InS2: in std_logic_vector(N downto 0);
    ---segnali registro Cod_Rx
    EnSendCod:in std_logic:='0';
    EnRxCod:in std_logic:='0';
    InCod: in std_logic_vector(DimCod downto 0);
    OutCod: out std_logic_vector(DimCod downto 0);
    --sel demux
    selDMux :in std_logic:='0';
    --sel mux
    selMux :in std_logic:='0';
     ---segnali registro scorrimento Tx
   
    ShiftTx:in std_logic:='0';
    LoadTx:in std_logic:='0';
    DataIn :in std_logic:='0';
    OutB : out std_logic:='0';
    
    --sengnale contatore SH
    EnContSh :in std_logic:='0';
    FlagStopSh :out std_logic:='0'
  );
end BparteOp;

architecture structural of BparteOp is
component Addizionatore is
	generic(N:integer:=7);
	port(
		A : in std_logic_vector(N downto 0):="00000000";
		B : in std_logic_vector(N downto 0):="00000000";
		S : out std_logic_vector(N downto 0):="00000000"
	);
end component;


component comparatore is
    generic(N:natural:=8);
    Port (
        input_1 : in std_logic_vector(N-1 downto 0);
        input_2 : in std_logic_vector(N-1 downto 0);
        output : out std_logic_vector(N-1 downto 0)--uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );
end component;


component RegistroB is
   generic(N: natural:=7);
	port(
		ClockRx: in std_logic;
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

component demux_1_2 is
   generic( N:integer:=7);
    Port ( 
	   x : in STD_LOGIC_VECTOR(N downto 0);
	   s : in STD_LOGIC;
           y0 : out STD_LOGIC_VECTOR(N downto 0);
           y1 : out STD_LOGIC_VECTOR(N downto 0)
           );
end component;





component mux_2_1 is
   generic( N:integer:=7);
    Port ( a0 : in STD_LOGIC_VECTOR(N downto 0);
           a1 : in STD_LOGIC_VECTOR(N downto 0);
           s : in STD_LOGIC;
           y : out STD_LOGIC_VECTOR(N downto 0));
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

component ContModNS is
    
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           stopCount : out STD_LOGIC :='0'
           );
           
end component;

component ContModNC is
    
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           stopCount : out STD_LOGIC :='0'
           );
           
end component;



signal inputSomm1,inputSomm2,OutSommTmp,inputCmp1,inputCmp2,OutCmpTmp:std_logic_vector(N downto 0);

signal OutS1Tmp,OutS2Tmp :std_logic_vector(N downto 0);
signal OutMuxTmp ,Data_out_par:std_logic_vector(N downto 0);
begin

S1_Rx: RegistroB 
	port map(
		ClockRx =>ClockB,
		
		InRx =>InS1,
		WriteRx =>EnRx1,
		ReadRx =>EnSend1,
		OutRx =>OutS1Tmp
	);

S2_Rx: RegistroB 
	port map(
		ClockRx =>ClockB,
		
		InRx =>InS2,
		WriteRx =>EnRx2,
		ReadRx =>EnSend2,
		OutRx =>OutS2Tmp
	);

Cod_Rx: RegistroB1 
	port map(
		ClockRx =>ClockB,
		ResetRx =>ResetB,
		InRx =>InCod,
		WriteRx =>EnRxCod,
		ReadRx =>EnSendCod,
		OutRx =>OutCod
	);

----defininsco i demux

demux1: demux_1_2
    Port map ( 
	   x =>OutS1Tmp,
	   s =>selDMux,
       y0 =>inputSomm1,
       y1 =>inputCmp1
);

demux2: demux_1_2
    Port map ( 
	   x =>OutS2Tmp,
	   s =>selDMux,
       y0 =>inputSomm2,
       y1 =>inputCmp2
);





Sommatore:Addizionatore 
	port map(
		A  =>inputSomm1,
		B  =>inputSomm2,
		S  =>OutSommTmp
	);


Comp:comparatore 
    
    Port map (
        input_1 =>inputCmp1,
        input_2 =>inputCmp2,
        output =>OutCmpTmp --uscita 1 equivale a  ingressi uguali viceversa per uscita 0
        );


Mux1:mux_2_1 
    Port  map ( 
           a0 =>OutSommTmp,
           a1 =>OutCmpTmp,
           s =>selMux,
           y =>OutMuxTmp);
---registro sh Tx


TxShiftRegister: shift_register 

port map (
    i_clk=>ClockB,
    i_rstb =>'0',
    i_data =>DataIn,
    i_data_par=>OutMuxTmp,
    o_data_ser=>OutB,
    o_data_par  => Data_out_par,
    enable_read=>LoadTx,
    enable_sh=>ShiftTx
    
    
    
    
    
 );


ContSh:ContModNS 
    Port map ( 
           clock =>ClockB,
           reset =>ResetB,
		   enable=>EnContSh,
           stopCount => FlagStopSh
           );


end structural;
