library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Handshake is
    Port ( 
        ClockA: in std_logic;
        ClockB: in std_logic;
        ResetA: in std_logic;
        ResetB: in std_logic;
        Start:  in std_logic
    );
end Handshake;

architecture Behavioral of Handshake is

Component NodoA is port(
        ClockA: in std_logic;
        ResetA: in std_logic;
        StartA: in std_logic;
        
        --handshake
        Req_to_B: out std_logic;
        OK_by_B:  in std_logic;
        Out_data: out std_logic_vector(3 downto 0)
);
end Component;

Component NodoB is port(
            ClockB: in std_logic;
            ResetB: in std_logic := '0';
            
            ---segnali handshake
            ReqA_B: in std_logic;
            OkB_A:  out std_logic := '0';
            DatoA:  in std_logic_vector(3 downto 0)
);
end Component;

signal ok_signal: std_logic;
signal req_signal: std_logic;
signal data_signal: std_logic_vector(3 downto 0);

begin

A: NodoA port map(
        ClockA   => ClockA,
        ResetA   => ResetA,
        StartA   => Start,
        
        --handshake
        Req_to_B    => req_signal,
        OK_by_B     => ok_signal,
        Out_data    => data_signal
);

B: NodoB port map(
            ClockB => ClockB,
            ResetB => ResetB,
            
            ---segnali handshake
            ReqA_B   => req_signal,
            OkB_A    => ok_signal,
            DatoA    => data_signal
);

end Behavioral;