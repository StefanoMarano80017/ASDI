library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ReteComplessiva is
  Port ( 
        Start:  in std_logic    := '0';
        ResetA: in std_logic    := '0';
        ClockA: in std_logic    := '0';
        ResetB: in std_logic    := '0';
        ClockB: in std_logic    := '0'
  );
end ReteComplessiva;

architecture structural of ReteComplessiva is

component NodoA is Port ( 
        ClockA : in  STD_LOGIC:='0';
		ResetA : in  STD_LOGIC:='0';
		StartA: in  STD_LOGIC:='0';
		OkB: in std_logic;
		ReqA: out std_logic;
		link_Tx_Rx:out  STD_LOGIC:='0'
  );
end component;

component NodoB is Port (   
          ClockB : in  STD_LOGIC:='0';
		  ResetB : in  STD_LOGIC:='0';
		  Link_Rx_Tx : in  STD_LOGIC;
		  OkB: out std_logic;
		  reqA: in std_logic 
);
end component;

signal OkB:         std_logic;
signal reqA:        std_logic;
signal Link_Rx_Tx:  std_logic;

begin


A: NodoA
port map(
        ClockA => ClockA,
		ResetA => ResetA,
		StartA => Start,
		OkB    => OkB,
		ReqA   => ReqA,
		link_Tx_Rx => Link_Rx_Tx
);

B: NodoB
port map(
          ClockB      => ClockB,
		  ResetB      => ResetB,
		  Link_Rx_Tx  => Link_Rx_Tx,
		  OkB         => OkB,
		  reqA        => reqA
);

end structural;