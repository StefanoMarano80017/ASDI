library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MemoriaRom is

Port(
		  ClkIn : in  STD_LOGIC;
		  RstIn : in  STD_LOGIC;
		  ReadEn : in  STD_LOGIC;
		  EndRead :out STD_LOGIC;
		  OutData : out std_logic_vector(3 downto 0):= (others => '0')
			  );
end MemoriaRom;

architecture Structural of MemoriaRom is
COMPONENT ContModN is
    Port ( clock : in  STD_LOGIC;
           reset : in  STD_LOGIC;
		   enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
           counter : out  STD_LOGIC_VECTOR (2 downto 0):= (others => '0');
           stopCount : out STD_LOGIC);
end COMPONENT;


component ROM is
generic(
        AddrLen: natural :=2;
        DataLen: natural :=3
);

port(
    CLK : in std_logic; 
    RST : in std_logic;                  
    READ : in std_logic; 
    ADDR : in std_logic_vector(AddrLen downto 0); 
    DATA : out std_logic_vector(DataLen downto 0) 
    );
end  component;
signal address : std_logic_vector(2 downto 0) := "000";
begin

counterN: ContModN
PORT MAP (
    clock => ClkIn,
    reset => RstIn,
	enable => ReadEn,
	stopCount=>EndRead,
	counter => address
	);

mem: ROM
PORT MAP (
    CLK => ClkIn, 
    RST => RstIn,
    read => readEn,
    addr => address,
    data => OutData
    );

end Structural;