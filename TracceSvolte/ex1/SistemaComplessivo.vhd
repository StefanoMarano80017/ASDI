library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SistemaComplessivo is
    Port ( 
        ClockA: in std_logic;
        ResetA: in std_logic;
        StartA: in std_logic;
        ClockB: in std_logic;
        ResetB: in std_logic
);
end SistemaComplessivo;

architecture Behavioral of SistemaComplessivo is

Component NodoB is
Port ( 
        ClockB: in std_logic;
        ResetB: in std_logic;
        
        ---handshake
        Data_in: in std_logic_vector(4 downto 0);
        ReqA:   in std_logic;
        OkB:    out std_logic
);
end component;

Component NodoA is
Port ( 
        ClockA: in std_logic;
        ResetA: in std_logic;
        StartA: in std_logic;
        
        ---handshake
        ReqA: out std_logic;
        okB:  in std_logic;
        
        ---Dati
        Data: out std_logic_vector(4 downto 0)
);
end component;

signal ReqA: std_logic;
signal OkB:  std_logic;
signal Data: std_logic_vector(4 downto 0);

begin

A: NodoA
port map(
    ClockA => ClockA,
    ResetA => ResetA,
    StartA => StartA,
    ReqA   => ReqA,
    OkB    => OkB,
    Data   => Data
);

B: NodoB
port map(
    ClockB => ClockB,
    ResetB => ResetB,
    ReqA   => ReqA,
    OkB    => OkB,
    Data_in   => Data
);

end Behavioral;