library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoB is
    Port (
            ClockB: in std_logic;
            ResetB: in std_logic := '0';
            
            ---segnali handshake
            ReqA_B: in std_logic;
            OkB_A:  out std_logic := '0';
            DatoA:  in std_logic_vector(3 downto 0)
    );
end NodoB;

architecture Behavioral of NodoB is

--PARTE DI CONTROLLO
component nodob_Cp is
    Port (    
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        
        ReqA: in std_logic;
        OkA: out std_logic := '0';
        
        --segnali controllo parte operativa
        EnRic: out std_logic;
        ReadRic: out std_logic;
        RdMEM: out std_logic;
        WrMEM: out std_logic;
        IncMEM: out std_logic;
        StopMEM: in std_logic;
        DoADD: out std_logic         
    );
end component;

--PARTE OPERATIVA
component Nodod_Op is
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
end component;

signal Rx_enable:   std_logic;
signal Rx_read:     std_logic; 
signal Mem_read:    std_logic;
signal Mem_write:   std_logic;
signal Mem_set:     std_logic;
signal Mem_stop:    std_logic;
signal Add_enable:  std_logic;

begin

Parte_Controllo:nodob_Cp 
    port map(
        ClockB  => ClockB,
        ResetB  => ResetB,
        
        ReqA    => ReqA_B,
        OkA     => OkB_A,
        
        EnRic   => Rx_enable,
        ReadRic => Rx_read,
        RdMEM   => Mem_read,
        WrMEM   => Mem_write,
        IncMEM  => Mem_set,
        StopMEM => Mem_stop,
        DoADD   => Add_enable       
    );

Parte_Operativa: Nodod_Op 
    port map(
        DatoFromA   => DatoA,
        ClockB      => ClockB,
        ResetB      => ResetB,
        EnRx        => Rx_enable,
        EnAdd       => Add_enable,
        SendRx      => Rx_read,
        WriteMem    => Mem_write,
        ReadMem     => Mem_read,
        STOP_SUM    => Mem_stop,
        SetMem      => Mem_set
    );
end Behavioral;