library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NodoA is
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
end NodoA;

architecture Behavioral of NodoA is

component NodoA_pc is
    port(
        StartA: in std_logic;
        ClockA: in std_logic;
        ResetA: in std_logic;
        
        ReqA:   out std_logic;
        OkB:    in  std_logic;
        
        tx:     out std_logic;
        read:   out std_logic;
        mem_val:    in  std_logic_vector(4 downto 0);
        addr:   out std_logic_vector(3 downto 0)
);
end component;

component MemR is
    generic(
            AddrLen: natural :=3;
            DataLen: natural :=4;
            NumberCells: natural :=7
    );
    port(
        CLK : in std_logic; 
                           
        READ : in std_logic;
                              
        ADDR : in std_logic_vector(AddrLen downto 0);    
        DATAOUT : out std_logic_vector(DataLen downto 0) 
     );
end component;

component Registro is
   generic(
            N: natural:= 4
   );
	port(
		ClockRx, ResetRx: in std_logic;
		InRx: in std_logic_vector(N downto 0);
		WriteRx: in std_logic;
		ReadRx: in std_logic;
		OutRx: out std_logic_vector(N downto 0)
	);
end component;

signal tx: std_logic;
signal read: std_logic;
signal addr: std_logic_vector(3 downto 0);
signal mem_out: std_logic_vector(4 downto 0);

begin

UC: NodoA_pc
port map(
        StartA  => StartA,
        ClockA  => ClockA,
        ResetA  => ResetA,
        
        ReqA    => ReqA,
        OkB     => OkB,
        
        tx      => tx,
        read    => read,
        mem_val => mem_out,
        addr    => addr
);

MEMA: MemR
port map(
        CLK     => ClockA, 
                           
        READ    => read,
                              
        ADDR    => addr,
        DATAOUT => mem_out
);

Reg: Registro
port map(
		ClockRx   => ClockA,
		ResetRx   => ResetA,
		InRx      => mem_out,
		WriteRx   => read, ---ATTENZIONE QUI
		ReadRx    => tx,
		OutRx     => Data
);

end Behavioral;
