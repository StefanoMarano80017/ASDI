library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Nodod_Op is
 Port (
        DatoFromA:  in std_logic_vector(3 downto 0);
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        EnRx:   in std_logic;
        EnAdd : in  STD_LOGIC;
        SendRx: in std_logic;
        WriteMem:in std_logic;
        ReadMem:in std_logic;
        STOP_SUM:out std_logic:= '0';
        SetMem: in std_logic := '0'
 );
end Nodod_Op;

architecture structural of Nodod_Op is

component Memoria is
        generic(DataLen: natural :=3);
        Port(
             ClkIn : in  STD_LOGIC;
             RstIn : in  STD_LOGIC;
             EnRead : in  STD_LOGIC;
             EnWrite : in  STD_LOGIC;
             EndRead :out STD_LOGIC;
             cnt: in STD_LOGIC;
             InData : in std_logic_vector(DataLen downto 0);
             OutData : out std_logic_vector(DataLen downto 0)
        );
end component;
    
component Registro is
        generic(N: natural:=3);
	    port(
            ClockRx, ResetRx: in std_logic;
            InRx: in std_logic_vector(N downto 0);
            WriteRx: in std_logic;
            ReadRx: in std_logic;
            OutRx: out std_logic_vector(N downto 0)
	   );
end component;

component Addizionatore is
	    generic(
	       N:integer:=3
	    );
	    port(
             A : in std_logic_vector(N downto 0);
             B : in std_logic_vector(N downto 0);
             EN:in std_logic;
             S : out std_logic_vector(N downto 0)
	    );
end component;

signal OutFromRx: std_logic_vector(3 downto 0):= "0000";
signal OutFromMem: std_logic_vector(3 downto 0):= "0000";
signal OutFromAdd: std_logic_vector(3 downto 0):= "0000";

begin

Memoria_ADD: Memoria     
        Port Map(
             ClkIn      => ClockB,
             RstIn      => ResetB,
             EnRead     => ReadMem,
             EnWrite    => '0',
             cnt        => SetMem,
             InData     => "0000",   
             OutData    => OutFromMem
        );
        
Memoria_SUM: Memoria
        Port Map(
            ClkIn   => ClockB,
            RstIn   => ResetB,
            EnRead  => '0',
            EnWrite => WriteMem,
            cnt     => SetMem, 
            EndRead => STOP_SUM,
            InData  => OutFromAdd
        );
        
RX: Registro
	    port map(
            ClockRx  => ClockB, 
            ResetRx  => ResetB,
            InRx     => DatoFromA,
            WriteRx  => EnRx,
            ReadRx   => SendRx,
            OutRx    => OutFromRx
	   );
	   
Sum:Addizionatore 
        port map(
             A      => OutFromRx,
             EN     => EnAdd,
             B      => OutFromMem,
             S      => OutFromAdd
	    );
	    
end structural;