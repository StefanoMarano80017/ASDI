library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemR is
    generic(
            AddrLen: natural :=2;
            DataLen: natural :=7;
            NumberCells: natural :=7
    );
    port(
        CLK : in std_logic; 
                           
        READ : in std_logic;
                              
        ADDR : in std_logic_vector(AddrLen downto 0);    
        DATAOUT : out std_logic_vector(DataLen downto 0) 
     );
end MemR;

architecture behavioural of MemR is 

type mem_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal MEM : mem_type := (
"00000111",
"00001111",
"00011111",
"00111111",
"01000001",
"00100011",
"00010010",
"00001000"
);

begin

R_mem:process(CLK, READ)
variable MEM_addr: natural range 0 to NumberCells;
begin
    MEM_addr := conv_integer(ADDR);
    if (CLK' event and CLK='0') then
        if READ = '1' then 
            DATAOUT <= MEM(MEM_addr);
        end if;
    end if; 
end process;
end behavioural;