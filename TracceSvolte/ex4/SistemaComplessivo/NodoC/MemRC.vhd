library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MemRC is
generic(
        AddrLen: natural :=3;
        DataLen: natural :=7;
        NumberCells: natural :=7
);

port(
    CLK : in std_logic:='0'; 
    RST : in std_logic:='0'; 
    WRITE : in std_logic:='0'; 
    ADDR : in std_logic_vector(AddrLen downto 0); 
                                           
    DATAIN : in std_logic_vector(DataLen downto 0)
     
    );
end MemRC;

-- creo una RAM di NumberCells elementi da DataLen bit ciascuno
architecture behavioural of MemRC is 
type ram_type is array (0 to NumberCells) of std_logic_vector(DataLen downto 0);
signal RAM : ram_type := (
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000",
"00000000"
);

--attribute rom_style : string;
--attribute rom_style of ROM : signal is "block";-- block dice al tool di sintesi di inferire blocchi di RAMB, 
                                               -- distributed di usare le LUT

begin
Write_RAM:process(CLK)
begin

    if (CLK' event and CLK='0') then
        if (RST ='1' ) then
            RAM<= (others => (others => '0'));
        elsif (WRITE ='1') then
             RAM(conv_integer(ADDR)) <=DATAIN;      
        end if;     
    end if; 
       
end process;
end behavioural;