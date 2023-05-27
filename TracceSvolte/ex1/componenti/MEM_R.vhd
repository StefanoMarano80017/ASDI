library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemR is
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
end MemR;

architecture behavioural of MemR is 

type mem_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal MEM : mem_type := (
"00000",
"00101",
"00110",
"01101",
"01110",
"01100",
"01011",
"10001"
);

begin

R_mem:process(CLK, READ)

variable MEM_addr: natural range 0 to NumberCells := 0;

begin
    MEM_addr := conv_integer(ADDR);
    if (CLK' event and CLK='0') then
        if READ = '1' then 
            DATAOUT <= MEM(MEM_addr);
        end if;
    end if; 
end process;

end behavioural;
