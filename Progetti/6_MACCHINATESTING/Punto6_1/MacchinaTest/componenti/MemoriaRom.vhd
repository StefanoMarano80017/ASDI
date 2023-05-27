library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity MemoriaRom is
generic(N:integer:=3);
  Port ( 
        CLOCK:in std_logic;
        RESET:in std_logic;
        ENREAD:in std_logic;
        ENWRITE :out std_logic;
        OUTDATA : out std_logic_vector(N downto 0)
        
  
  );
end MemoriaRom;

architecture structural of MemoriaRom is
component ContRom is
        generic(N:integer:=3);
	       port(
		      Clk, Rst: in std_logic:='0';
		      EnCont : in std_logic:='0';
		      OutCont : out std_logic_vector (N downto 0):= (others => '0')
	       );
    end component;
    
    component ROM is
        generic(
            AddrLen: natural :=3;
            DataLen: natural :=3;
            NumberCells: natural :=15
        );
        port(
            CLK : in std_logic; 
            RST : in std_logic; 
            ADDR : in std_logic_vector(AddrLen downto 0);
            FLAGWRITE : out std_logic;
            READ : in std_logic;  
            DATA : out std_logic_vector(DataLen downto 0) 
        );
    end component;

signal address :  std_logic_vector (3 downto 0):= (others => '0');
    
    
   
    begin
        ContatoreRom: ContRom 
	       port map(
		      Clk =>CLOCK,
		      Rst=>RESET,
		      EnCont =>ENREAD,
		      OutCont =>address
		  );
        MemRom: ROM 
           port map(
              CLK =>CLOCK, 
              RST =>RESET, 
              ADDR =>address,
              FLAGWRITE =>ENWRITE,
              READ =>ENREAD,  
              DATA =>OUTDATA 
        );

end structural;
