library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemRw is
    generic(
            AddrLen: natural :=3;
            DataLen: natural :=1;
            NumberCells: natural :=7
    );
    port(
        CLK : in std_logic; 
        RST : in std_logic; 
                           
        READ : in std_logic;
        WRITE : in std_logic; 
                              
        ADDR : in std_logic_vector(AddrLen downto 0);    
        DATAIN : in std_logic_vector(DataLen downto 0);
        DATAOUT : out std_logic_vector(DataLen downto 0) 
     );
end MemRw;

architecture behavioural of MemRw is 

type mem_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal MEM : mem_type := (others => (others => '0'));

begin

RW_mem:process(CLK, WRITE, READ, RST)
variable MEM_addr: natural range 0 to NumberCells;
begin

    MEM_addr := conv_integer(ADDR);
    if (CLK' event and CLK='0') then
    
        if WRITE = '1' and READ = '0' then 
            MEM(MEM_addr) <= DATAIN; 
        end if;
    
        if READ = '1' and WRITE = '0' then 
            DATAOUT <= MEM(MEM_addr);
        end if;
     
        if  RST = '1' and WRITE = '0' and READ = '0' then
            MEM <= (others => (others => '0'));
        end if;
    end if; 
       
end process;
end behavioural;
