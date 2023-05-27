library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA is
    generic(
        Datalen: natural := 3
    );
    port(
        ClockA: in std_logic;
        ResetA: in std_logic;
        StartA: in std_logic;
        
        --handshake
        Req_to_B: out std_logic;
        OK_by_B:  in std_logic;
        Out_data: out std_logic_vector(Datalen downto 0)
    );
end NodoA;

architecture structural of NodoA is 

component NodoA_po is Port ( 
        Clock: in std_logic;
        Reset: in std_logic;
        
        EnTx:in std_logic;
        SetMEM :in std_logic;
        ReadMEM:in std_logic;
        StopMEM:out std_logic:= '0';
        OUT_FROM_A : out std_logic_vector(3 downto 0)
    );
end component;

component NodoA_pc is port(
        StartA: in std_logic;
        ClockA: in std_logic;
        ResetA: in std_logic;
        
        ReqA:   out std_logic;
        OkB:    in  std_logic;
        
        rx:     out std_logic;
        read:   out std_logic;
        stop:   in std_logic;
        set:    out std_logic
    );
end component;

signal EnTx:    std_logic;
signal SetMEM : std_logic;
signal ReadMEM: std_logic;
signal StopMEM: std_logic;

begin 

Parte_Operativa: NodoA_po port map(
        Clock   => ClockA,
        Reset   => ResetA,
        
        EnTx    => EnTX,
        SetMEM  => SetMEM,
        ReadMEM => ReadMEM,
        StopMEM => StopMEM,
        OUT_FROM_A  => Out_data
);

Parte_Controllo: NodoA_pc port map(
        StartA  => StartA,
        ClockA  => ClockA,
        ResetA  => ResetA,
        
        ReqA    => Req_to_B,
        OkB     => OK_by_B,
        
        rx      => EnTX,
        read    => ReadMEM,
        stop    => StopMEM,
        set     => SetMEM
);

end structural;