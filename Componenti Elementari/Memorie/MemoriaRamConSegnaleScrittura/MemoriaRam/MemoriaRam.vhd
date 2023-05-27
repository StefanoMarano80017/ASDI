
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MemoriaRam is
generic( N:integer:=3);
    Port(
            ClkIn : in  STD_LOGIC;
            RstIn : in  STD_LOGIC;
	        WriteEn : in  STD_LOGIC;
	        CountEn : in  STD_LOGIC;
            InData : in std_logic_vector(N downto 0);
            EndWrite : out  STD_LOGIC
	);
end MemoriaRam;

architecture structural of MemoriaRam is
    component ContModN is
        generic(N:natural:=3);
        Port (  clock : in  STD_LOGIC;
                reset : in  STD_LOGIC;
		        enable : in STD_LOGIC; --questo è l'enable del clock, insieme danno l'impulso di conteggio
                counter : out  STD_LOGIC_VECTOR (N downto 0);
                stopCount : out STD_LOGIC :='0'
        );
    end component;
    component RAM is
    generic(
        AddrLen: natural :=3;
        DataLen: natural :=3;
        NumberCells: natural :=7
    );
    port(
        CLK : in std_logic; 
        RST : in std_logic; 
        WRITE : in std_logic; 
        ADDR : in std_logic_vector(AddrLen downto 0):= (others => '0'); 
        DATA : in std_logic_vector(DataLen downto 0) 
    );
end component;
signal address : std_logic_vector(3 downto 0) := "0000";
begin
    ContatoreMod8: ContModN 
     Port map (
            clock =>ClkIn,
            reset =>RstIn,
            enable =>CountEn,
            counter =>address,
            stopCount =>EndWrite
     );
Mem: RAM 
    port map(
        CLK =>ClkIn,
        RST =>RstIn, 
        WRITE =>WriteEn,
        ADDR =>address,
        DATA =>InData
    );
end structural;
