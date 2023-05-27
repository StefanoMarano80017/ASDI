library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity MacchinaTesting is
    generic(N:natural:=2);
    Port ( 
        Clock: in std_logic;
        Reset: in std_logic;
        EnableOp: in std_logic;
        OutputData: out std_logic_vector(N downto 0)
    );
end MacchinaTesting;
architecture structural of MacchinaTesting is
  component MemoriaRom is
generic(N:integer:=3);
  Port ( 
        CLOCK:in std_logic;
        RESET:in std_logic;
        ENREAD:in std_logic;
        ENWRITE :out std_logic;
        OUTDATA : out std_logic_vector(N downto 0)
        
  
  );
end component;
    component MacchinaComb4_3 is
        Port ( 
            x: in std_logic_vector(3 downto 0);
            y: out std_logic_vector(2 downto 0)
        );
    end component;
  
    component MemoriaRam is
        generic(
            AddrLen: natural :=3;
            DataLen: natural :=2;
            NumberCells: natural :=15
        );
        port(
            CLK: in std_logic;
	       WRITE: in std_logic;
	       RST: in std_logic;
	       DATAIN: in  std_logic_vector (DataLen DOWNTO 0);
	       DATAOUT: out  std_logic_vector (DataLen DOWNTO 0)
        );
    END component;  
    
    signal address :  std_logic_vector (3 downto 0):= (others => '0');
    signal OutFromRom :  std_logic_vector(3 downto 0);
    signal OutFromMacComb :  std_logic_vector(2 downto 0);
    signal Enwrite:std_logic:='0';
    begin
        MemRom: MemoriaRom 
        Port  map( 
            CLOCK=>Clock,
            RESET=>Reset,
            ENREAD=>EnableOp,
            ENWRITE =>Enwrite,
            OUTDATA =>OutFromRom
        );

        Macch4_3: MacchinaComb4_3 
        Port map ( 
            x=>OutFromRom,
            y=>OutFromMacComb
        );
       
        MemRam: MemoriaRam 
        port map(
            CLK=>Clock,
	        WRITE=>Enwrite,
	        RST =>Reset,
	        DATAIN=>OutFromMacComb,
	        DATAOUT=>OutputData
	    );
 
end structural;
