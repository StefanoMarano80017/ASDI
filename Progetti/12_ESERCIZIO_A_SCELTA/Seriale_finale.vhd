library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Seriale_finale is
    Port ( 
        ClockA: in std_logic;
        ClockB: in std_logic;
        resetA: in std_logic;
        resetB: in std_logic;
        StartA: in std_logic
    );
end Seriale_finale;

architecture Behavioral of Seriale_finale is

component Tx_seriale is
    port ( 
        Data_out: out std_logic;
        
        ReqA: out std_logic;
        okB: in std_logic;
        
        Clock: in std_logic;
        reset: in std_logic;
        
        StartA: in std_logic
    );
end component;

component Rx_seriale is
Port ( 
        Data_in: in std_logic;
        
        ReqA: in std_logic;
        okB: out std_logic;
        
        Clock: in std_logic;
        reset: in std_logic
);
end component;

signal Data: std_logic;
signal ReqA: std_logic;
signal okB: std_logic;

begin

A: Tx_seriale
port map(
        Data_out => Data,
        
        ReqA => ReqA,
        okB  => okB,
        
        Clock => ClockA,
        reset => resetA,
        
        StartA => StartA
);

B: Rx_seriale
port map(
        Data_in => Data,
        
        ReqA => ReqA,
        okB  => okB,
        
        Clock => ClockB,
        reset => resetB
);

end Behavioral;