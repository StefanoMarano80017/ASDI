library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoB is
    Port ( 
        ClockB: in std_logic;
        ResetB: in std_logic;
        
        ---handshake
        Data_in: in std_logic_vector(4 downto 0);
        ReqA:   in std_logic;
        OkB:    out std_logic
    );
end NodoB;

architecture Behavioral of NodoB is

component B_PO is
Port ( 
    Clock:   in std_logic;
    Reset:   in std_logic;
    
    Data_in: in std_logic_vector(4 downto 0);
    EnRic:   in std_logic;
    ReadRic: in std_logic;
    cnt:     in std_logic;
    wrt:     in std_logic
);
end component;


component nodob_Cp is
    Port (    
        ClockB: in std_logic;
        ResetB: in std_logic := '0';
        
        ReqA: in std_logic;
        OkB: out std_logic := '0';
        
        --segnali controllo parte operativa
        EnRic: out std_logic;
        ReadRic: out std_logic;
        WrMEM: out std_logic;
        IncMEM: out std_logic
);
end component;

signal EnRic:   std_logic;
signal ReadRic: std_logic;
signal IncMEM:  std_logic;
signal WrMEM:   std_logic;

begin

PO: B_PO 
Port map( 
    Clock   => ClockB,
    Reset   => ResetB,
    
    Data_in  => Data_in,
    EnRic    => EnRic,
    ReadRic  => ReadRic,
    cnt      => IncMEM,
    wrt      => WrMEM
);

PC: nodob_Cp 
Port map(    
        ClockB  => ClockB,
        ResetB  => ResetB,
        
        ReqA    => ReqA,
        OkB     => OkB,
        
        --segnali controllo parte operativa
        EnRic   => EnRic,
        ReadRic => ReadRic,
        WrMEM   => WrMEM,
        IncMEM  => IncMEM
);

end Behavioral;
