library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA_po is
    generic (
        DataLen: natural := 3
    );
    Port ( 
        Clock: in std_logic;
        Reset: in std_logic;
        
        EnTx:in std_logic;
        SetMEM :in std_logic;
        ReadMEM:in std_logic;
        StopMEM:out std_logic:= '0';
        OUT_FROM_A : out std_logic_vector(3 downto 0) := "0000"
    );
end NodoA_po;

architecture Behavioral of NodoA_po is

component Memoria is
        generic(
            DataLen: natural :=3
        );
        Port(
             ClkIn : in  STD_LOGIC;
             RstIn : in  STD_LOGIC;
             EnRead : in  STD_LOGIC;
             EnWrite : in  STD_LOGIC;
             EndRead :out STD_LOGIC;
             cnt: in STD_LOGIC;
             OutData : out std_logic_vector(DataLen downto 0);
             InData:   in std_logic_vector(DataLen downto 0)
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

signal OutMEM: std_logic_vector(DataLen downto 0);

begin

MEM: Memoria port map(
    ClkIn   => Clock,
    RstIn   => reset, 
    EnRead  => ReadMEM,
    EnWrite => '0',
    EndRead => StopMEM,
    cnt     => SetMEM,
    InData  => "0000",
    OutData => OutMEM
);

RX: Registro port map(
    ClockRx     => Clock,
    ResetRx     => Reset,
    InRx        => OutMEM,
    ReadRX      => EnTx,
    WriteRx     => ReadMEM,
    OutRx       => OUT_FROM_A
);


end Behavioral;
